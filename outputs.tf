# Información de conexión MySQL
output "mysql_connection_info" {
  description = "Información de conexión a MySQL"
  value = {
    host           = "localhost"
    port           = var.mysql_external_port
    database       = var.mysql_database
    username       = var.mysql_user
    container_name = "${var.project_name}-mysql"
    network        = docker_network.database_network.name
  }
}

# URLs de acceso
output "phpmyadmin_local_url" {
  description = "URL local de phpMyAdmin"
  value       = "http://localhost:${var.phpmyadmin_external_port}"
}

output "phpmyadmin_container_info" {
  description = "Información del contenedor phpMyAdmin"
  value = {
    name        = "${var.project_name}-phpmyadmin"
    port        = var.phpmyadmin_external_port
    internal_ip = "172.20.0.20"
  }
}

# Comandos útiles
output "useful_commands" {
  description = "Comandos útiles para gestionar la infraestructura"
  value = {
    ngrok_logs        = "docker logs ${var.project_name}-ngrok"
    mysql_logs        = "docker logs ${var.project_name}-mysql"
    phpmyadmin_logs   = "docker logs ${var.project_name}-phpmyadmin"
    mysql_connect     = "docker exec -it ${var.project_name}-mysql mysql -u ${var.mysql_user} -p"
    containers_status = "docker ps --filter label=project=${var.project_name}"
  }
}

# Información de red
output "network_info" {
  description = "Información de la red Docker"
  value = {
    name          = docker_network.database_network.name
    subnet        = var.network_subnet
    mysql_ip      = "172.20.0.10"
    phpmyadmin_ip = "172.20.0.20"
    ngrok_ip      = "172.20.0.30"
  }
}

# Información de volúmenes
output "volumes_info" {
  description = "Información de los volúmenes"
  value = {
    mysql_data   = docker_volume.mysql_data.name
    ngrok_config = docker_volume.ngrok_config.name
  }
}

# Instrucciones para obtener URL de ngrok
output "ngrok_url_instructions" {
  description = "Instrucciones para obtener la URL pública de ngrok"
  value       = "Ejecuta: docker logs ${var.project_name}-ngrok | grep 'started tunnel' | tail -1"
}
# output "ngrok_public_url" {
#   description = "URL pública generada por ngrok"
#   value       = local.ngrok_api_response.tunnels[0].public_url
# }

