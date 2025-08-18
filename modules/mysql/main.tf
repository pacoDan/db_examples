# modules/mysql/main.tf
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "mysql" {
  count = var.enabled ? 1 : 0
  name = "mysql:${var.mysql_version}"
  keep_locally = true
}

resource "docker_container" "mysql" {
  count = var.enabled ? 1 : 0
  image = docker_image.mysql[0].image_id
  name  = "${var.environment}-mysql-${var.instance_name}"

  ports {
    internal = 3306
    external = var.external_port
  }

  volumes {
    host_path      = abspath("${var.data_path}/mysql")
    container_path = "/var/lib/mysql"
  }

  env = [
    "MYSQL_ROOT_PASSWORD=${var.root_password}",
    "MYSQL_DATABASE=${var.database_name}",
    "MYSQL_USER=${var.username}",
    "MYSQL_PASSWORD=${var.password}"
  ]

  restart = "unless-stopped"
}

# phpMyAdmin
resource "docker_image" "phpmyadmin" {
  count = var.enabled && var.enable_phpmyadmin ? 1 : 0
  name = "phpmyadmin:${var.phpmyadmin_version}"
  keep_locally = true
}

resource "docker_container" "phpmyadmin" {
  count = var.enabled && var.enable_phpmyadmin ? 1 : 0
  image = docker_image.phpmyadmin[0].image_id
  name  = "${var.environment}-phpmyadmin-${var.instance_name}"

  ports {
    internal = 80
    external = var.phpmyadmin_port
  }

  env = [
    "PMA_HOST=${var.environment}-mysql-${var.instance_name}",
    "PMA_PORT=3306",
    "PMA_USER=root",
    "PMA_PASSWORD=${var.root_password}",
    "MYSQL_ROOT_PASSWORD=${var.root_password}"
  ]

  depends_on = [docker_container.mysql]
  restart = "unless-stopped"
}