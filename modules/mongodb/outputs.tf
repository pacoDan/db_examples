# modules/mongodb/outputs.tf
output "container_name" {
  description = "MongoDB container name"
  value       = var.enabled ? docker_container.mongodb[0].name : null
}

output "connection_string" {
  description = "MongoDB connection string"
  value       = var.enabled ? "mongodb://${var.username}:${var.password}@localhost:${var.external_port}/${var.database_name}" : null
  sensitive   = true
}