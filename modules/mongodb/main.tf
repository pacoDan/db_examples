terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "mongodb" {
  name = "mongo:${var.mongodb_version}"
}

resource "docker_container" "mongodb" {
  count = var.enabled ? 1 : 0
  image = docker_image.mongodb.image_id
  name  = "${var.environment}-mongodb-${var.instance_name}"
  
  ports {
    internal = 27017
    external = var.external_port
  }
  
  volumes {
    host_path      = "${var.data_path}/mongodb"
    container_path = "/data/db"
  }
  
  env = [
    "MONGO_INITDB_ROOT_USERNAME=${var.username}",
    "MONGO_INITDB_ROOT_PASSWORD=${var.password}",
    "MONGO_INITDB_DATABASE=${var.database_name}"
  ]
  
  restart = "unless-stopped"
}