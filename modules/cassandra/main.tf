terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "cassandra" {
  name = "cassandra:${var.cassandra_version}"
}

resource "docker_container" "cassandra" {
  count = var.enabled ? 1 : 0
  image = docker_image.cassandra.image_id
  name  = "${var.environment}-cassandra-${var.instance_name}"
  
  ports {
    internal = 9042
    external = var.external_port
  }
  
  volumes {
    host_path      = "${var.data_path}/cassandra"
    container_path = "/var/lib/cassandra"
  }
  
  env = [
    "CASSANDRA_CLUSTER_NAME=${var.cluster_name}",
    "CASSANDRA_DC=datacenter1",
    "CASSANDRA_RACK=rack1",
    "CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch"
  ]
  
  memory = 2048
  restart = "unless-stopped"
}
# # modules/cassandra/variables.tf
# variable "enabled" {
#   description = "Enable Cassandra deployment"
#   type        = bool
#   default     = false
# }

# variable "cassandra_version" {
#   description = "Cassandra version"
#   type        = string
#   default     = "4.1"
# }

# variable "external_port" {
#   description = "External port for Cassandra"
#   type        = number
#   default     = 9042
# }

# variable "cluster_name" {
#   description = "Cassandra cluster name"
#   type        = string
#   default     = "TestCluster"
# }

# variable "environment" {
#   description = "Environment name"
#   type        = string
# }

# variable "instance_name" {
#   description = "Instance identifier"
#   type        = string
#   default     = "main"
# }

# variable "data_path" {
#   description = "Host path for data persistence"
#   type        = string
#   default     = "./data"
# }

# # modules/cassandra/outputs.tf
# output "container_name" {
#   description = "Cassandra container name"
#   value       = var.enabled ? docker_container.cassandra[0].name : null
# }

# output "external_port" {
#   description = "External port for Cassandra"
#   value       = var.enabled ? var.external_port : null
# }