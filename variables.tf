# variables.tf
variable "environment" {
  description = "Nombre del ambiente"
  type        = string
  default     = "dev"
}

variable "data_path" {
  description = "Ruta para datos persistentes"
  type        = string
  default     = "./data"
}

# Habilitar bases de datos
variable "enable_redis" {
  description = "Habilitar Redis"
  type        = bool
  default     = false
}

variable "enable_postgresql" {
  description = "Habilitar PostgreSQL"
  type        = bool
  default     = false
}

variable "enable_mysql" {
  description = "Habilitar MySQL"
  type        = bool
  default     = false
}

variable "enable_sqlserver" {
  description = "Habilitar SQL Server"
  type        = bool
  default     = false
}

variable "enable_mongodb" {
  description = "Habilitar MongoDB"
  type        = bool
  default     = false
}

variable "enable_cassandra" {
  description = "Habilitar Cassandra"
  type        = bool
  default     = false
}

variable "enable_neo4j" {
  description = "Habilitar Neo4j"
  type        = bool
  default     = false
}

# Cliente web settings
variable "enable_web_clients" {
  description = "Habilitar clientes web para todas las bases de datos"
  type        = bool
  default     = true
}

# Puertos de bases de datos
variable "redis_port" {
  description = "Puerto para Redis"
  type        = number
  default     = 6379
}

variable "postgres_port" {
  description = "Puerto para PostgreSQL"
  type        = number
  default     = 5432
}

variable "mysql_port" {
  description = "Puerto para MySQL"
  type        = number
  default     = 3306
}

variable "sqlserver_port" {
  description = "Puerto para SQL Server"
  type        = number
  default     = 1433
}

variable "mongodb_port" {
  description = "Puerto para MongoDB"
  type        = number
  default     = 27017
}

variable "cassandra_port" {
  description = "Puerto para Cassandra"
  type        = number
  default     = 9042
}

variable "neo4j_http_port" {
  description = "Puerto HTTP para Neo4j"
  type        = number
  default     = 7474
}

variable "neo4j_bolt_port" {
  description = "Puerto Bolt para Neo4j"
  type        = number
  default     = 7687
}

# Puertos de clientes web
variable "phpmyadmin_port" {
  description = "Puerto para phpMyAdmin"
  type        = number
  default     = 8080
}

variable "pgadmin_port" {
  description = "Puerto para pgAdmin"
  type        = number
  default     = 8081
}

variable "redis_commander_port" {
  description = "Puerto para Redis Commander"
  type        = number
  default     = 8082
}

variable "mongo_express_port" {
  description = "Puerto para Mongo Express"
  type        = number
  default     = 8083
}

# Passwords
variable "redis_password" {
  description = "Password para Redis"
  type        = string
  default     = ""
}

variable "postgres_password" {
  description = "Password para PostgreSQL"
  type        = string
  default     = "postgres"
}

variable "postgres_username" {
  description = "Usuario para PostgreSQL"
  type        = string
  default     = "postgres"
}

variable "postgres_db_name" {
  description = "Nombre de la base de datos PostgreSQL"
  type        = string
  default     = "testdb"
}

variable "mysql_password" {
  description = "Password root para MySQL"
  type        = string
  default     = "mysql"
}

variable "mysql_db_name" {
  description = "Nombre de la base de datos MySQL"
  type        = string
  default     = "testdb"
}

variable "sqlserver_password" {
  description = "Password SA para SQL Server"
  type        = string
  default     = "MySecurePassword123!"
}

variable "mongodb_username" {
  description = "Usuario para MongoDB"
  type        = string
  default     = "admin"
}

variable "mongodb_password" {
  description = "Password para MongoDB"
  type        = string
  default     = "admin"
}

variable "mongodb_database" {
  description = "Nombre de la base de datos MongoDB"
  type        = string
  default     = "testdb"
}

variable "cassandra_cluster_name" {
  description = "Nombre del cluster Cassandra"
  type        = string
  default     = "TestCluster"
}

variable "neo4j_password" {
  description = "Password para Neo4j"
  type        = string
  default     = "neo4j123"
}

# Configuración de clientes web
variable "pgadmin_email" {
  description = "Email para pgAdmin"
  type        = string
  default     = "admin@example.com"
}

variable "pgadmin_password" {
  description = "Password para pgAdmin"
  type        = string
  default     = "admin123"
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