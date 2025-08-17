# modules/mysql/outputs.tf
output "container_name" {
  description = "MySQL container name"
  value       = var.enabled ? docker_container.mysql[0].name : null
}

output "connection_string" {
  description = "MySQL connection string"
  value       = var.enabled ? "mysql://${var.username}:${var.password}@localhost:${var.external_port}/${var.database_name}" : null
  sensitive   = true
}

output "external_port" {
  description = "External port for MySQL"
  value       = var.enabled ? var.external_port : null
}