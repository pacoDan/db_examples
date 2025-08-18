# modules/postgresql/variables.tf
variable "enabled" {
  description = "Habilitar PostgreSQL"
  type        = bool
  default     = false
}

variable "environment" {
  description = "Nombre del ambiente"
  type        = string
  default     = "dev"
}

variable "external_port" {
  description = "Puerto externo para PostgreSQL"
  type        = number
  default     = 5432
}

variable "database_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "testdb"
}

variable "username" {
  description = "Usuario de PostgreSQL"
  type        = string
  default     = "postgres"
}

variable "password" {
  description = "Password de PostgreSQL"
  type        = string
  default     = "postgres"
}

variable "data_path" {
  description = "Ruta para datos persistentes"
  type        = string
  default     = "./data"
}

variable "postgres_version" {
  description = "Versión de PostgreSQL"
  type        = string
  default     = "15-alpine"
}

variable "instance_name" {
  description = "Nombre de la instancia"
  type        = string
  default     = "main"
}

# Variables para pgAdmin
variable "enable_pgadmin" {
  description = "Habilitar pgAdmin"
  type        = bool
  default     = true
}

variable "pgadmin_port" {
  description = "Puerto para pgAdmin"
  type        = number
  default     = 8081
}

variable "pgadmin_email" {
  description = "Email para pgAdmin"
  type        = string
  default     = "admin@example.com"
}

variable "pgadmin_password" {
  description = "Password para pgAdmin"
  type        = string
  default     = "admin123"
}

variable "pgadmin_version" {
  description = "Versión de pgAdmin"
  type        = string
  default     = "latest"
}