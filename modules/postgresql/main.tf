terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "postgres" {
  name = "postgres:${var.postgres_version}"
}

resource "docker_container" "postgres" {
  count = var.enabled ? 1 : 0
  image = docker_image.postgres.image_id
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