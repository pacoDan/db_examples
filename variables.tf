# Variables generales
variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  default     = "production"
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
  default     = "database-infrastructure"
}

# Variables de MySQL
variable "mysql_version" {
  description = "Versión de MySQL"
  type        = string
  default     = "8.0"
}

variable "mysql_root_password" {
  description = "Contraseña root para MySQL"
  type        = string
  sensitive   = true
}

variable "mysql_database" {
  description = "Nombre de la base de datos inicial"
  type        = string
  default     = "main_database"
}

variable "mysql_user" {
  description = "Usuario de MySQL"
  type        = string
  default     = "dbadmin"
}

variable "mysql_password" {
  description = "Contraseña del usuario MySQL"
  type        = string
  sensitive   = true
}

variable "mysql_external_port" {
  description = "Puerto externo para MySQL"
  type        = number
  default     = 3306
}

# Variables de phpMyAdmin
variable "phpmyadmin_version" {
  description = "Versión de phpMyAdmin"
  type        = string
  default     = "latest"
}

variable "phpmyadmin_external_port" {
  description = "Puerto externo para phpMyAdmin"
  type        = number
  default     = 8080
}

# Variables de ngrok
variable "ngrok_version" {
  description = "Versión de ngrok"
  type        = string
  default     = "latest"
}

variable "ngrok_authtoken" {
  description = "Token de autenticación de ngrok"
  type        = string
  sensitive   = true
}

variable "ngrok_region" {
  description = "Región de ngrok"
  type        = string
  default     = "us"

  validation {
    condition = contains([
      "us", "eu", "ap", "au", "sa", "jp", "in"
    ], var.ngrok_region)
    error_message = "La región debe ser una de: us, eu, ap, au, sa, jp, in."
  }
}

variable "ngrok_domain" {
  description = "Dominio personalizado de ngrok (opcional)"
  type        = string
  default     = ""
}

# Variables de red
variable "network_subnet" {
  description = "Subred para la red Docker"
  type        = string
  default     = "172.20.0.0/16"
}

variable "ngrok_tunnel_target" {
  description = "Servicio interno (host:puerto) que ngrok debe tunelar"
  type        = string
}

# Redis
variable "redis_version" {
  description = "Versión de Redis"
  type        = string
  default     = "7.0"
}

variable "redis_external_port" {
  description = "Puerto externo para Redis"
  type        = number
  default     = 6379
}

# MongoDB
variable "mongodb_version" {
  description = "Versión de MongoDB"
  type        = string
  default     = "6.0"
}

variable "mongodb_external_port" {
  description = "Puerto externo para MongoDB"
  type        = number
  default     = 27017
}

variable "mongodb_root_user" {
  description = "Usuario root de MongoDB"
  type        = string
  default     = "admin"
}

variable "mongodb_root_password" {
  description = "Contraseña root de MongoDB"
  type        = string
  sensitive   = true
}

# CASSANDRA
variable "cassandra_image" {
  description = "Imagen de Docker para Cassandra"
  type        = string
  default     = "cassandra"
}

variable "cassandra_version" {
  description = "Versión de Cassandra"
  type        = string
  default     = "4.1"
}

variable "container_name" {
  description = "Nombre del contenedor de Cassandra"
  type        = string
  default     = "cassandra-local"
}

variable "network_name" {
  description = "Nombre de la red Docker"
  type        = string
  default     = "cassandra-net"
}

variable "volume_name" {
  description = "Nombre del volumen para datos"
  type        = string
  default     = "cassandra-data"
}

variable "cassandra_port" {
  description = "Puerto CQL de Cassandra"
  type        = number
  default     = 9042
}

variable "cassandra_inter_node_port" {
  description = "Puerto de comunicación inter-nodo"
  type        = number
  default     = 7000
}

variable "cassandra_ssl_inter_node_port" {
  description = "Puerto SSL de comunicación inter-nodo"
  type        = number
  default     = 7001
}

variable "cassandra_jmx_port" {
  description = "Puerto JMX"
  type        = number
  default     = 7199
}

variable "cassandra_thrift_port" {
  description = "Puerto Thrift (legacy)"
  type        = number
  default     = 9160
}

variable "cluster_name" {
  description = "Nombre del cluster de Cassandra"
  type        = string
  default     = "Local Cluster"
}

variable "datacenter" {
  description = "Nombre del datacenter"
  type        = string
  default     = "datacenter1"
}

variable "rack" {
  description = "Nombre del rack"
  type        = string
  default     = "rack1"
}

variable "endpoint_snitch" {
  description = "Tipo de endpoint snitch"
  type        = string
  default     = "GossipingPropertyFileSnitch"
}

variable "num_tokens" {
  description = "Número de tokens virtuales"
  type        = number
  default     = 256
}

variable "max_heap_size" {
  description = "Tamaño máximo del heap de Java"
  type        = string
  default     = "512M"
}

variable "heap_newsize" {
  description = "Tamaño del heap para objetos nuevos"
  type        = string
  default     = "100M"
}

variable "memory_limit" {
  description = "Límite de memoria del contenedor en bytes"
  type        = number
  default     = 1073741824  # 1GB
}

variable "cassandra_username" {
  description = "Usuario de Cassandra"
  type        = string
  default     = "cassandra"
  sensitive   = true
}

variable "cassandra_password" {
  description = "Contraseña de Cassandra"
  type        = string
  default     = "cassandra"
  sensitive   = true
}

variable "enable_tools_container" {
  description = "Habilitar contenedor con herramientas de administración"
  type        = bool
  default     = true
}
