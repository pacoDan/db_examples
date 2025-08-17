terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "mysql" {
  name = "mysql:${var.mysql_version}"
}

resource "docker_container" "mysql" {
  count = var.enabled ? 1 : 0
  image = docker_image.mysql.image_id
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
    "MYSQL_PASSWORD=${var.password}",
    "MYSQL_ROOT_HOST=%"
  ]

  restart = "unless-stopped"
}