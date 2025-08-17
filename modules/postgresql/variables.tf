# modules/postgresql/variables.tf
variable "enabled" {
  description = "Enable PostgreSQL deployment"
  type        = bool
  default     = false
}

variable "postgres_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "15-alpine"
}

variable "external_port" {
  description = "External port for PostgreSQL"
  type        = number
  default     = 5432
}

variable "database_name" {
  description = "Initial database name"
  type        = string
  default     = "testdb"
}

variable "username" {
  description = "Database username"
  type        = string
  default     = "postgres"
}

variable "password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "instance_name" {
  description = "Instance identifier"
  type        = string
  default     = "main"
}

variable "data_path" {
  description = "Host path for data persistence"
  type        = string
  default     = "./data"
}