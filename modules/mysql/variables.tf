# modules/mysql/variables.tf
variable "enabled" {
  description = "Enable MySQL deployment"
  type        = bool
  default     = false
}

variable "mysql_version" {
  description = "MySQL version"
  type        = string
  default     = "8.0"
}

variable "external_port" {
  description = "External port for MySQL"
  type        = number
  default     = 3306
}

variable "database_name" {
  description = "Initial database name"
  type        = string
  default     = "testdb"
}

variable "username" {
  description = "Database username"
  type        = string
  default     = "testuser"
}

variable "password" {
  description = "Database user password"
  type        = string
  sensitive   = true
  default     = "testpass"
}

variable "root_password" {
  description = "MySQL root password"
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