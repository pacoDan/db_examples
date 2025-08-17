terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "cassandra" {
  count = var.enabled ? 1 : 0
  name = "cassandra:${var.cassandra_version}"
  keep_locally = true
}

resource "docker_container" "cassandra" {
  count = var.enabled ? 1 : 0
  image = docker_image.cassandra[0].image_id
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