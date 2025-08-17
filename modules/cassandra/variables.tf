variable "enabled" {
  description = "Enable Cassandra deployment"
  type        = bool
  default     = false
}

variable "cassandra_version" {
  description = "Cassandra version"
  type        = string
  default     = "4.1"
}

variable "external_port" {
  description = "External port for Cassandra"
  type        = number
  default     = 9042
}

variable "cluster_name" {
  description = "Cassandra cluster name"
  type        = string
  default     = "TestCluster"
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