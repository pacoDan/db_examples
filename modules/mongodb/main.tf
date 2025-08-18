terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# MongoDB
resource "docker_image" "mongodb" {
  count = var.enabled ? 1 : 0
  name = "mongo:${var.mongodb_version}"
  keep_locally = true
}

resource "docker_container" "mongodb" {
  count = var.enabled ? 1 : 0
  image = docker_image.mongodb[0].image_id
  name  = "${var.environment}-mongodb-${var.instance_name}"

  ports {
    internal = 27017
    external = var.external_port
  }

  volumes {
    host_path      = abspath("${var.data_path}/mongodb")
    container_path = "/data/db"
  }

  env = [
    "MONGO_INITDB_ROOT_USERNAME=${var.username}",
    "MONGO_INITDB_ROOT_PASSWORD=${var.password}",
    "MONGO_INITDB_DATABASE=${var.database_name}"
  ]

  restart = "unless-stopped"
}

# Mongo Express
resource "docker_image" "mongo_express" {
  count = var.enabled && var.enable_mongo_express ? 1 : 0
  name = "mongo-express:${var.mongo_express_version}"
  keep_locally = true
}

resource "docker_container" "mongo_express" {
  count = var.enabled && var.enable_mongo_express ? 1 : 0
  image = docker_image.mongo_express[0].image_id
  name  = "${var.environment}-mongo-express-${var.instance_name}"

  ports {
    internal = 8081
    external = var.mongo_express_port
  }

  env = [
    "ME_CONFIG_MONGODB_ADMINUSERNAME=${var.username}",
    "ME_CONFIG_MONGODB_ADMINPASSWORD=${var.password}",
    "ME_CONFIG_MONGODB_URL=mongodb://${var.username}:${var.password}@${var.environment}-mongodb-${var.instance_name}:27017/",
    "ME_CONFIG_BASICAUTH_USERNAME=${var.mongo_express_user}",
    "ME_CONFIG_BASICAUTH_PASSWORD=${var.mongo_express_password}"
  ]

  depends_on = [docker_container.mongodb]
  restart = "unless-stopped"
}