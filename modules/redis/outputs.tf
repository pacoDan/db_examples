# # modules/redis/outputs.tf
# output "container_name" {
#   description = "Redis container name"
#   value       = var.enabled ? docker_container.redis[0].name : null
# }

# output "external_port" {
#   description = "External port for Redis"
#   value       = var.enabled ? var.external_port : null
# }
output "container_id" {
  description = "ID del contenedor Redis"
  value       = var.enabled ? docker_container.redis[0].id : null
}

output "container_name" {
  description = "Nombre del contenedor Redis"
  value       = var.enabled ? docker_container.redis[0].name : null
}

output "connection_string" {
  description = "String de conexión para Redis"
  value       = var.enabled ? "redis://localhost:${var.external_port}" : null
  sensitive   = true
}