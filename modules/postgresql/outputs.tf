# modules/postgresql/outputs.tf
output "container_name" {
  description = "PostgreSQL container name"
  value       = var.enabled ? docker_container.postgres[0].name : null
}

output "connection_string" {
  description = "PostgreSQL connection string"
  value       = var.enabled ? "postgresql://${var.username}:${var.password}@localhost:${var.external_port}/${var.database_name}" : null
  sensitive   = true
}

output "external_port" {
  description = "External port for PostgreSQL"
  value       = var.enabled ? var.external_port : null
}