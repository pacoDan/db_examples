# modules/mongodb/variables.tf
variable "enabled" {
  description = "Habilitar MongoDB"
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
  description = "MongoDB admin username"
  type        = string
  default     = "admin"
}

variable "password" {
  description = "MongoDB admin password"
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "Initial database name"
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

# AGREGAR ESTAS VARIABLES QUE FALTAN:
variable "enable_mongo_express" {
  description = "Habilitar Mongo Express"
  type        = bool
  default     = true
}

variable "mongo_express_port" {
  description = "Puerto para Mongo Express"
  type        = number
  default     = 8083
}

variable "mongo_express_user" {
  description = "Usuario para Mongo Express"
  type        = string
  default     = "admin"
}

variable "mongo_express_password" {
  description = "Password para Mongo Express"
  type        = string
  default     = "pass"
}

variable "mongo_express_version" {
  description = "Versión de Mongo Express"
  type        = string
  default     = "latest"
}