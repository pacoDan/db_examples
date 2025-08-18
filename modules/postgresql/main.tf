terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "postgres" {
  count = var.enabled ? 1 : 0
  name = "postgres:${var.postgres_version}"
  keep_locally = true
}

resource "docker_container" "postgres" {
  count = var.enabled ? 1 : 0
  image = docker_image.postgres[0].image_id
  name  = "${var.environment}-postgres-${var.instance_name}"
  
  ports {
    internal = 5432
    external = var.external_port
  }
  
  volumes {
    host_path      = abspath("${var.data_path}/postgres")
    container_path = "/var/lib/postgresql/data"
  }
  
  env = [
    "POSTGRES_DB=${var.database_name}",
    "POSTGRES_USER=${var.username}",
    "POSTGRES_PASSWORD=${var.password}",
    "PGDATA=/var/lib/postgresql/data/pgdata"
  ]
  
  restart = "unless-stopped"
}
# pgAdmin
resource "docker_image" "pgadmin" {
  count = var.enabled && var.enable_pgadmin ? 1 : 0
  name = "dpage/pgadmin4:${var.pgadmin_version}"
  keep_locally = true
}

resource "docker_container" "pgadmin" {
  count = var.enabled && var.enable_pgadmin ? 1 : 0
  image = docker_image.pgadmin[0].image_id
  name  = "${var.environment}-pgadmin-${var.instance_name}"

  ports {
    internal = 80
    external = var.pgadmin_port
  }

  volumes {
    host_path      = abspath("${var.data_path}/pgadmin")
    container_path = "/var/lib/pgadmin"
  }

  env = [
    "PGADMIN_DEFAULT_EMAIL=${var.pgadmin_email}",
    "PGADMIN_DEFAULT_PASSWORD=${var.pgadmin_password}",
    "PGADMIN_CONFIG_SERVER_MODE=False"
  ]

  user = "root"
  restart = "unless-stopped"
}