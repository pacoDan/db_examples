output "container_name" {
  description = "Cassandra container name"
  value       = var.enabled ? docker_container.cassandra[0].name : null
}

output "external_port" {
  description = "External port for Cassandra"
  value       = var.enabled ? var.external_port : null
}