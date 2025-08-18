# main.tf
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Redis Module
module "redis" {
  source = "./modules/redis"

  enabled        = var.enable_redis
  environment    = var.environment
  external_port  = var.redis_port
  data_path      = var.data_path
  redis_password = var.redis_password

  # Redis Commander
  enable_redis_commander = var.enable_web_clients
  redis_commander_port   = var.redis_commander_port
}

# PostgreSQL Module
module "postgresql" {
  source = "./modules/postgresql"

  enabled       = var.enable_postgresql
  environment   = var.environment
  external_port = var.postgres_port
  database_name = var.postgres_db_name
  username      = var.postgres_username
  password      = var.postgres_password
  data_path     = var.data_path

  # pgAdmin
  enable_pgadmin    = var.enable_web_clients
  pgadmin_port      = var.pgadmin_port
  pgadmin_email     = var.pgadmin_email
  pgadmin_password  = var.pgadmin_password
}

# MySQL Module
module "mysql" {
  source = "./modules/mysql"

  enabled       = var.enable_mysql
  environment   = var.environment
  external_port = var.mysql_port
  root_password = var.mysql_password
  database_name = var.mysql_db_name
  data_path     = var.data_path

  # phpMyAdmin
  enable_phpmyadmin = var.enable_web_clients
  phpmyadmin_port   = var.phpmyadmin_port
}

# SQL Server Module
module "sqlserver" {
  source = "./modules/sqlserver"

  enabled       = var.enable_sqlserver
  environment   = var.environment
  external_port = var.sqlserver_port
  sa_password   = var.sqlserver_password
  data_path     = var.data_path
}

# Cassandra Module
module "cassandra" {
  source = "./modules/cassandra"

  enabled       = var.enable_cassandra
  environment   = var.environment
  external_port = var.cassandra_port
  cluster_name  = var.cassandra_cluster_name
  data_path     = var.data_path
}

# MongoDB Module
module "mongodb" {
  source = "./modules/mongodb"

  enabled       = var.enable_mongodb
  environment   = var.environment
  external_port = var.mongodb_port
  username      = var.mongodb_username
  password      = var.mongodb_password
  database_name = var.mongodb_database
  data_path     = var.data_path
  # Mongo Express
  enable_mongo_express = var.enable_web_clients
  mongo_express_port   = var.mongo_express_port
  mongo_express_user   = var.mongo_express_user
  mongo_express_password = var.mongo_express_password
}

# Neo4j Module
module "neo4j" {
  source = "./modules/neo4j"

  enabled     = var.enable_neo4j
  environment = var.environment
  http_port   = var.neo4j_http_port
  bolt_port   = var.neo4j_bolt_port
  password    = var.neo4j_password
  data_path   = var.data_path
}