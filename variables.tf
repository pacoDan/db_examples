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
