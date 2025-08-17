# modules/sqlserver/variables.tf
variable "enabled" {
  description = "Enable SQL Server deployment"
  type        = bool
  default     = false
}

variable "sqlserver_version" {
  description = "SQL Server version"
  type        = string
  default     = "2022-latest"
}

variable "external_port" {
  description = "External port for SQL Server"
  type        = number
  default     = 1433
}

variable "sa_password" {
  description = "SQL Server SA password (must meet complexity requirements)"
  type        = string
  sensitive   = true
  validation {
    condition = length(var.sa_password) >= 8 && can(regex("[A-Z]", var.sa_password)) && can(regex("[a-z]", var.sa_password)) && can(regex("[0-9]", var.sa_password))
    error_message = "SA password must be at least 8 characters and contain uppercase, lowercase, and numeric characters."
  }
}

variable "edition" {
  description = "SQL Server edition (Express, Developer, Standard, Enterprise)"
  type        = string
  default     = "Express"
}

variable "collation" {
  description = "SQL Server collation"
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "initial_database" {
  description = "Initial database to create"
  type        = string
  default     = "TestDB"
}

variable "memory_limit" {
  description = "Memory limit for SQL Server container (in MB)"
  type        = number
  default     = 2048
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