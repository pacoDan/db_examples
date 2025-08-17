# modules/mongodb/variables.tf
variable "enabled" {
  description = "Enable MongoDB deployment"
  type        = bool
  default     = false
}

variable "mongodb_version" {
  description = "MongoDB version"
  type        = string
  default     = "7.0"
}

variable "external_port" {
  description = "External port for MongoDB"
  type        = number
  default     = 27017
}

variable "username" {
  description = "MongoDB username"
  type        = string
  default     = "admin"
}

variable "password" {
  description = "MongoDB password"
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "MongoDB initial database"
  type        = string
  default     = "testdb"
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