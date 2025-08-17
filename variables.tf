# variables.tf - Archivo principal de variables
# Global Variables
variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
  default     = "dev"
}

variable "data_path" {
  description = "Host path for data persistence"
  type        = string
  default     = "./data"
}

# Redis Variables
variable "enable_redis" {
  description = "Enable Redis deployment"
  type        = bool
  default     = false
}

variable "redis_port" {
  description = "External port for Redis"
  type        = number
  default     = 6379
}

variable "redis_password" {
  description = "Redis password"
  type        = string
  sensitive   = true
  default     = "redis123"
}

# PostgreSQL Variables
variable "enable_postgresql" {
  description = "Enable PostgreSQL deployment"
  type        = bool
  default     = false
}

variable "postgres_port" {
  description = "External port for PostgreSQL"
  type        = number
  default     = 5432
}

variable "postgres_db_name" {
  description = "PostgreSQL initial database name"
  type        = string
  default     = "testdb"
}

variable "postgres_username" {
  description = "PostgreSQL username"
  type        = string
  default     = "postgres"
}

variable "postgres_password" {
  description = "PostgreSQL password"
  type        = string
  sensitive   = true
  default     = "postgres123"
}

# MySQL Variables
variable "enable_mysql" {
  description = "Enable MySQL deployment"
  type        = bool
  default     = false
}

variable "mysql_port" {
  description = "External port for MySQL"
  type        = number
  default     = 3306
}

variable "mysql_password" {
  description = "MySQL root password"
  type        = string
  sensitive   = true
  default     = "MySecurePassword123!"
}

variable "mysql_db_name" {
  description = "MySQL initial database name"
  type        = string
  default     = "testdb"
}

# SQL Server Variables
variable "enable_sqlserver" {
  description = "Enable SQL Server deployment"
  type        = bool
  default     = false
}

variable "sqlserver_port" {
  description = "External port for SQL Server"
  type        = number
  default     = 1433
}

variable "sqlserver_password" {
  description = "SQL Server SA password"
  type        = string
  sensitive   = true
  default     = "MySecurePassword123!"
}

# Cassandra Variables
variable "enable_cassandra" {
  description = "Enable Cassandra deployment"
  type        = bool
  default     = false
}

variable "cassandra_port" {
  description = "External port for Cassandra"
  type        = number
  default     = 9042
}

variable "cassandra_cluster_name" {
  description = "Cassandra cluster name"
  type        = string
  default     = "TestCluster"
}

# Neo4j Variables
variable "enable_neo4j" {
  description = "Enable Neo4j deployment"
  type        = bool
  default     = false
}

variable "neo4j_http_port" {
  description = "External HTTP port for Neo4j"
  type        = number
  default     = 7474
}

variable "neo4j_bolt_port" {
  description = "External Bolt port for Neo4j"
  type        = number
  default     = 7687
}

variable "neo4j_password" {
  description = "Neo4j password"
  type        = string
  sensitive   = true
  default     = "neo4j123"
}

# MongoDB Variables
variable "enable_mongodb" {
  description = "Enable MongoDB deployment"
  type        = bool
  default     = false
}

variable "mongodb_port" {
  description = "External port for MongoDB"
  type        = number
  default     = 27017
}

variable "mongodb_username" {
  description = "MongoDB username"
  type        = string
  default     = "admin"
}

variable "mongodb_password" {
  description = "MongoDB password"
  type        = string
  sensitive   = true
  default     = "mongodb123"
}

variable "mongodb_database" {
  description = "MongoDB initial database"
  type        = string
  default     = "testdb"
}