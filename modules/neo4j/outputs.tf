# modules/neo4j/outputs.tf
output "container_name" {
  description = "Neo4j container name"
  value       = var.enabled ? docker_container.neo4j[0].name : null
}

output "http_url" {
  description = "Neo4j HTTP URL"
  value       = var.enabled ? "http://localhost:${var.http_port}" : null
}

output "bolt_url" {
  description = "Neo4j Bolt URL"
  value       = var.enabled ? "bolt://localhost:${var.bolt_port}" : null
}