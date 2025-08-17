# modules/sqlserver/outputs.tf
output "container_name" {
  description = "SQL Server container name"
  value       = var.enabled ? docker_container.sqlserver[0].name : null
}

output "connection_string" {
  description = "SQL Server connection string"
  value       = var.enabled ? "Server=localhost,${var.external_port};User Id=sa;Password=${var.sa_password};TrustServerCertificate=true;" : null
  sensitive   = true
}

output "external_port" {
  description = "External port for SQL Server"
  value       = var.enabled ? var.external_port : null
}

output "sa_username" {
  description = "SQL Server SA username"
  value       = var.enabled ? "sa" : null
}