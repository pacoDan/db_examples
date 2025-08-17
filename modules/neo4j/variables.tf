# modules/neo4j/variables.tf
variable "enabled" {
  description = "Enable Neo4j deployment"
  type        = bool
  default     = false
}

variable "neo4j_version" {
  description = "Neo4j version"
  type        = string
  default     = "5.15"
}

variable "http_port" {
  description = "External HTTP port for Neo4j"
  type        = number
  default     = 7474
}

variable "bolt_port" {
  description = "External Bolt port for Neo4j"
  type        = number
  default     = 7687
}

variable "password" {
  description = "Neo4j password"
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