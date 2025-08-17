# modules/redis/outputs.tf
output "container_name" {
  description = "Redis container name"
  value       = var.enabled ? docker_container.redis[0].name : null
}

output "external_port" {
  description = "External port for Redis"
  value       = var.enabled ? var.external_port : null
}