# Red Docker personalizada
resource "docker_network" "database_network" {
  name   = "${var.project_name}-network"
  driver = "bridge"

  ipam_config {
    subnet = var.network_subnet
  }

  labels {
    label = "project"
    value = var.project_name
  }

  labels {
    label = "environment"
    value = var.environment
  }
}

# Volúmenes persistentes
resource "docker_volume" "mysql_data" {
  name = "${var.project_name}-mysql-data"

  labels {
    label = "service"
    value = "mysql"
  }

  labels {
    label = "environment"
    value = var.environment
  }
}

resource "docker_volume" "ngrok_config" {
  name = "${var.project_name}-ngrok-config"

  labels {
    label = "service"
    value = "ngrok"
  }
}

# Imágenes Docker
resource "docker_image" "mysql" {
  name         = "mysql:${var.mysql_version}"
  keep_locally = true

  pull_triggers = ["mysql:${var.mysql_version}"]
}

resource "docker_image" "phpmyadmin" {
  name         = "phpmyadmin:${var.phpmyadmin_version}"
  keep_locally = true

  pull_triggers = ["phpmyadmin:${var.phpmyadmin_version}"]
}

resource "docker_image" "ngrok" {
  name         = "ngrok/ngrok:${var.ngrok_version}"
  keep_locally = true

  pull_triggers = ["ngrok/ngrok:${var.ngrok_version}"]
}

# ----------------------------
# MySQL Container
# ----------------------------
resource "docker_container" "mysql" {
  image = docker_image.mysql.image_id
  name  = "${var.project_name}-mysql"

  restart = "unless-stopped"

  networks_advanced {
    name         = docker_network.database_network.name
    ipv4_address = "172.20.0.10"
  }

  ports {
    internal = 3306
    external = var.mysql_external_port
  }

  volumes {
    volume_name    = docker_volume.mysql_data.name
    container_path = "/var/lib/mysql"
  }

  # Configuración de MySQL optimizada
  env = [
    "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}",
    "MYSQL_DATABASE=${var.mysql_database}",
    "MYSQL_USER=${var.mysql_user}",
    "MYSQL_PASSWORD=${var.mysql_password}",
    "MYSQL_CHARACTER_SET_SERVER=utf8mb4",
    "MYSQL_COLLATION_SERVER=utf8mb4_unicode_ci",
    "MYSQL_INNODB_BUFFER_POOL_SIZE=256M"
  ]

  # Health check para MySQL
  healthcheck {
    test = [
      "CMD-SHELL",
      "mysqladmin ping -h localhost -u root -p${var.mysql_root_password} || exit 1"
    ]
    interval     = "30s"
    timeout      = "10s"
    retries      = 5
    start_period = "60s"
  }

  # Configuración de recursos
  memory = 512

  labels {
    label = "service"
    value = "mysql"
  }

  labels {
    label = "environment"
    value = var.environment
  }

  labels {
    label = "project"
    value = var.project_name
  }

   # ... otros atributos del contenedor ... ante el cambio de contraseña
  # Reemplazo del contenedor si la contraseña cambia
  # Agrega esta sección
  lifecycle {
    replace_triggered_by = [
      # null_resource.mysql_password_changed
      null_resource.password_trigger
    ]
  }
  depends_on = [
    null_resource.password_trigger # Depende del recurso para que se active el cambio
  ]
}
# resource "null_resource" "mysql_password_changed" {
#   triggers = {
#     root_password = var.mysql_root_password
#   }
# }
# Este recurso es un "gatillo" para forzar la recreación de contenedores
# cuando cambian variables sensibles, como contraseñas.
resource "null_resource" "password_trigger" {
  triggers = {
    mysql_password = var.mysql_root_password
    # Puedes añadir más contraseñas aquí si fuera necesario
    # por ejemplo, redis_password = var.redis_password
    # y luego usar esta misma dependencia en los demás contenedores.
  }
}
# ----------------------------
# phpMyAdmin Container
# ----------------------------
resource "docker_container" "phpmyadmin" {
  image = docker_image.phpmyadmin.image_id
  name  = "${var.project_name}-phpmyadmin"

  restart = "unless-stopped"

  networks_advanced {
    name         = docker_network.database_network.name
    # ipv4_address = "172.20.0.20"
  }

  ports {
    internal = 80
    external = var.phpmyadmin_external_port
  }

  # Configuración de phpMyAdmin
  env = [
    "PMA_HOST=${var.project_name}-mysql",
    "PMA_PORT=3306",
    # "PMA_USER=${var.mysql_user}",
    "PMA_USER=root",  # Cambiado de var.mysql_user a "root"
    # "PMA_PASSWORD=${var.mysql_password}",
    "PMA_PASSWORD=${var.mysql_root_password}", # Cambiado de var.mysql_password a var.mysql_root_password
    "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}",
    "PMA_ARBITRARY=1",
    "PMA_ABSOLUTE_URI=http://localhost:${var.phpmyadmin_external_port}",
    "UPLOAD_LIMIT=2G",
    "MEMORY_LIMIT=2G",
    "MAX_EXECUTION_TIME=600"
  ]

  # Configuración de recursos
  memory = 256

  depends_on = [docker_container.mysql]

  labels {
    label = "service"
    value = "phpmyadmin"
  }

  labels {
    label = "environment"
    value = var.environment
  }

  labels {
    label = "project"
    value = var.project_name
  }
  # ... otros atributos del contenedor ...

  lifecycle {
    replace_triggered_by = [
      null_resource.password_trigger
    ]
  }
}

# ----------------------------
# ngrok Container
# ----------------------------
resource "docker_container" "ngrok" {
  image = docker_image.ngrok.image_id
  name  = "${var.project_name}-ngrok"

  restart = "unless-stopped"

  networks_advanced {
    name = docker_network.database_network.name
    # ipv4_address = "172.20.0.30"
  }

  # volumes {
  #   volume_name    = docker_volume.ngrok_config.name
  #   container_path = "/home/ngrok/.config/ngrok"
  # }

  env = [
    "NGROK_AUTHTOKEN=${var.ngrok_authtoken}"
  ]

  # Comando para exponer phpMyAdmin
  # command = concat([
  #   "http", 
  #   "${var.project_name}-phpmyadmin:80",
  #   "--region=${var.ngrok_region}"
  # ], var.ngrok_domain != "" ? ["--domain=${var.ngrok_domain}"] : [])
  command = concat([
    "http",
    var.ngrok_tunnel_target,
    "--region=${var.ngrok_region}","--log=stdout"
  ], var.ngrok_domain != "" ? ["--domain=${var.ngrok_domain}"] : [])

  depends_on = [docker_container.phpmyadmin]

  labels {
    label = "service"
    value = "ngrok"
  }

  labels {
    label = "environment"
    value = var.environment
  }

  labels {
    label = "project"
    value = var.project_name
  }
}
# ----------------------------
# Redis Container
# ----------------------------
resource "docker_volume" "redis_data" {
  name = "${var.project_name}-redis-data"
}

resource "docker_image" "redis" {
  name         = "redis:${var.redis_version}"
  keep_locally = true
}

resource "docker_container" "redis" {
  image = docker_image.redis.image_id
  name  = "${var.project_name}-redis"

  restart = "unless-stopped"

  networks_advanced {
    name         = docker_network.database_network.name
    ipv4_address = "172.20.0.40"
  }

  ports {
    internal = 6379
    external = var.redis_external_port
  }

  volumes {
    volume_name    = docker_volume.redis_data.name
    container_path = "/data"
  }

  memory = 256

  labels {
    label = "service"
    value = "redis"
  }

  labels {
    label = "environment"
    value = var.environment
  }

  labels {
    label = "project"
    value = var.project_name
  }
}

# ----------------------------
# MongoDB Container
# ----------------------------
resource "docker_volume" "mongodb_data" {
  name = "${var.project_name}-mongodb-data"
}

resource "docker_image" "mongodb" {
  name         = "mongo:${var.mongodb_version}"
  keep_locally = true
}

resource "docker_container" "mongodb" {
  image = docker_image.mongodb.image_id
  name  = "${var.project_name}-mongodb"

  restart = "unless-stopped"

  networks_advanced {
    name         = docker_network.database_network.name
    ipv4_address = "172.20.0.50"
  }

  ports {
    internal = 27017
    external = var.mongodb_external_port
  }

  volumes {
    volume_name    = docker_volume.mongodb_data.name
    container_path = "/data/db"
  }

  env = [
    "MONGO_INITDB_ROOT_USERNAME=${var.mongodb_root_user}",
    "MONGO_INITDB_ROOT_PASSWORD=${var.mongodb_root_password}"
  ]

  memory = 512

  labels {
    label = "service"
    value = "mongodb"
  }

  labels {
    label = "environment"
    value = var.environment
  }

  labels {
    label = "project"
    value = var.project_name
  }
}
