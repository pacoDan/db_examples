terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "redis" {
  name = "redis:${var.redis_version}"
}

resource "docker_container" "redis" {
  count = var.enabled ? 1 : 0
  image = docker_image.redis.image_id
  name  = "${var.environment}-redis-${var.instance_name}"
  
  ports {
    internal = 6379
    external = var.external_port
  }
  
  volumes {
    host_path      = "${var.data_path}/redis"
    container_path = "/data"
  }
  
  env = var.redis_password != "" ? [
    "REDIS_PASSWORD=${var.redis_password}"
  ] : []
  
  restart = "unless-stopped"
}