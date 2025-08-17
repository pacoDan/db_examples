terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "redis" {
  count = var.enabled ? 1 : 0  # ← AGREGAR ESTA LÍNEA para controlar la creación de la imagen
  name = "redis:${var.redis_version}"
  keep_locally = true  # ← AGREGAR ESTA LÍNEA # Evita que la imagen se borre al hacer destroy
}

resource "docker_container" "redis" {
  count = var.enabled ? 1 : 0
  image = docker_image.redis[0].image_id
  name  = "${var.environment}-redis-${var.instance_name}"

  ports {
    internal = 6379
    external = var.external_port
  }

  volumes {
    host_path      = abspath("${var.data_path}/redis")
    container_path = "/data"
  }

  env = var.redis_password != "" ? [
    "REDIS_PASSWORD=${var.redis_password}"
  ] : []

  restart = "unless-stopped"
}