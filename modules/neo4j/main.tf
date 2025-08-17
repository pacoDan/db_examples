terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "neo4j" {
  count = var.enabled ? 1 : 0
  name = "neo4j:${var.neo4j_version}"
  keep_locally = true
}

resource "docker_container" "neo4j" {
  count = var.enabled ? 1 : 0
  image = docker_image.neo4j[0].image_id
  name  = "${var.environment}-neo4j-${var.instance_name}"
  
  ports {
    internal = 7474
    external = var.http_port
  }
  
  ports {
    internal = 7687
    external = var.bolt_port
  }
  
  volumes {
    host_path      = "${var.data_path}/neo4j/data"
    container_path = "/data"
  }
  
  volumes {
    host_path      = "${var.data_path}/neo4j/logs"
    container_path = "/logs"
  }
  
  env = [
    "NEO4J_AUTH=neo4j/${var.password}",
    "NEO4J_PLUGINS=[\"apoc\"]"
  ]
  
  restart = "unless-stopped"
}