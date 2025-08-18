# modules/redis/variables.tf
variable "enabled" {
  description = "Habilitar Redis"
  type        = bool
  default     = false
}

variable "redis_version" {
  description = "Redis version"
  type        = string
  default     = "7-alpine"
}

variable "external_port" {
  description = "External port for Redis"
  type        = number
  default     = 6379
}

variable "redis_password" {
  description = "Redis password"
  type        = string
  sensitive   = true
  default     = ""
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

# Variables para Redis Commander
variable "enable_redis_commander" {
  description = "Habilitar Redis Commander"
  type        = bool
  default     = true
}

variable "redis_commander_port" {
  description = "Puerto para Redis Commander"
  type        = number
  default     = 8082
}

variable "redis_commander_version" {
  description = "Versión de Redis Commander"
  type        = string
  default     = "latest"
}