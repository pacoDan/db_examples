variable "enabled" {
  description = "Enable Redis deployment"
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

variable "redis_password" {
  description = "Redis password"
  type        = string
  sensitive   = true
  default     = ""
}