
# outputs.tf
output "deployed_databases" {
  description = "List of deployed databases"
  value = {
    redis      = var.enable_redis ? "localhost:${var.redis_port}" : null
    postgresql = var.enable_postgresql ? "localhost:${var.postgres_port}" : null
    mysql      = var.enable_mysql ? "localhost:${var.mysql_port}" : null
    sqlserver  = var.enable_sqlserver ? "localhost:${var.sqlserver_port}" : null
    cassandra  = var.enable_cassandra ? "localhost:${var.cassandra_port}" : null
    neo4j      = var.enable_neo4j ? "http://localhost:${var.neo4j_http_port}" : null
    mongodb    = var.enable_mongodb ? "localhost:${var.mongodb_port}" : null
  }
}

output "connection_info" {
  description = "Connection information for deployed databases"
  value = {
    redis = var.enable_redis ? {
      host              = "localhost"
      port              = var.redis_port
      password          = var.redis_password
      connection_string = "redis://:${var.redis_password}@localhost:${var.redis_port}"
    } : null

    postgresql = var.enable_postgresql ? {
      host              = "localhost"
      port              = var.postgres_port
      database          = var.postgres_db_name
      username          = var.postgres_username
      password          = var.postgres_password
      connection_string = "postgresql://${var.postgres_username}:${var.postgres_password}@localhost:${var.postgres_port}/${var.postgres_db_name}"
    } : null

    mysql = var.enable_mysql ? {
      host              = "localhost"
      port              = var.mysql_port
      database          = var.mysql_db_name
      username          = "root"
      password          = var.mysql_password
      connection_string = "mysql://root:${var.mysql_password}@localhost:${var.mysql_port}/${var.mysql_db_name}"
    } : null

    sqlserver = var.enable_sqlserver ? {
      host              = "localhost"
      port              = var.sqlserver_port
      username          = "sa"
      password          = var.sqlserver_password
      connection_string = "Server=localhost,${var.sqlserver_port};User Id=sa;Password=${var.sqlserver_password};TrustServerCertificate=true;"
    } : null

    neo4j = var.enable_neo4j ? {
      http_host         = "localhost"
      http_port         = var.neo4j_http_port
      bolt_port         = var.neo4j_bolt_port
      username          = "neo4j"
      password          = var.neo4j_password
      http_url          = "http://localhost:${var.neo4j_http_port}"
      bolt_url          = "bolt://localhost:${var.neo4j_bolt_port}"
      connection_string = "bolt://neo4j:${var.neo4j_password}@localhost:${var.neo4j_bolt_port}"
    } : null

    cassandra = var.enable_cassandra ? {
      host              = "localhost"
      port              = var.cassandra_port
      cluster_name      = var.cassandra_cluster_name
      connection_string = "cassandra://localhost:${var.cassandra_port}"
    } : null

    mongodb = var.enable_mongodb ? {
      host              = "localhost"
      port              = var.mongodb_port
      database          = var.mongodb_database
      username          = var.mongodb_username
      password          = var.mongodb_password
      connection_string = "mongodb://${var.mongodb_username}:${var.mongodb_password}@localhost:${var.mongodb_port}/${var.mongodb_database}"
    } : null
  }
  sensitive = true
}

output "docker_containers" {
  description = "Docker container names for deployed databases"
  value = {
    redis      = module.redis.container_name
    postgresql = module.postgresql.container_name
    mysql      = module.mysql.container_name
    sqlserver  = module.sqlserver.container_name
    cassandra  = module.cassandra.container_name
    neo4j      = module.neo4j.container_name
    mongodb    = module.mongodb.container_name
  }
}

output "database_urls" {
  description = "Direct URLs for database access"
  value = {
    redis_cli      = var.enable_redis ? "redis-cli -h localhost -p ${var.redis_port} -a ${var.redis_password}" : null
    postgresql_cli = var.enable_postgresql ? "psql -h localhost -p ${var.postgres_port} -U ${var.postgres_username} -d ${var.postgres_db_name}" : null
    mysql_cli      = var.enable_mysql ? "mysql -h localhost -P ${var.mysql_port} -u root -p${var.mysql_password} ${var.mysql_db_name}" : null
    sqlserver_cli  = var.enable_sqlserver ? "sqlcmd -S localhost,${var.sqlserver_port} -U sa -P ${var.sqlserver_password}" : null
    cassandra_cli  = var.enable_cassandra ? "cqlsh localhost ${var.cassandra_port}" : null
    neo4j_browser  = var.enable_neo4j ? "http://localhost:${var.neo4j_http_port}/browser/" : null
    mongodb_cli    = var.enable_mongodb ? "mongosh mongodb://${var.mongodb_username}:${var.mongodb_password}@localhost:${var.mongodb_port}/${var.mongodb_database}" : null
  }
  sensitive = true
}

output "health_check_commands" {
  description = "Commands to check database health"
  value = {
    redis      = var.enable_redis ? "docker exec ${var.environment}-redis-main redis-cli ping" : null
    postgresql = var.enable_postgresql ? "docker exec ${var.environment}-postgres-main pg_isready -U ${var.postgres_username}" : null
    mysql      = var.enable_mysql ? "docker exec ${var.environment}-mysql-main mysqladmin ping -h localhost" : null
    sqlserver  = var.enable_sqlserver ? "docker exec ${var.environment}-sqlserver-main /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${var.sqlserver_password} -Q 'SELECT 1'" : null
    cassandra  = var.enable_cassandra ? "docker exec ${var.environment}-cassandra-main cqlsh -e 'describe cluster'" : null
    neo4j      = var.enable_neo4j ? "docker exec ${var.environment}-neo4j-main cypher-shell -u neo4j -p ${var.neo4j_password} 'RETURN 1'" : null
    mongodb    = var.enable_mongodb ? "docker exec ${var.environment}-mongodb-main mongosh --eval 'db.adminCommand(\"ping\")'" : null
  }
  sensitive = true
}

output "data_volumes" {
  description = "Data volume paths for backup purposes"
  value = {
    redis      = var.enable_redis ? "${var.data_path}/redis" : null
    postgresql = var.enable_postgresql ? "${var.data_path}/postgres" : null
    mysql      = var.enable_mysql ? "${var.data_path}/mysql" : null
    sqlserver  = var.enable_sqlserver ? "${var.data_path}/sqlserver" : null
    cassandra  = var.enable_cassandra ? "${var.data_path}/cassandra" : null
    neo4j      = var.enable_neo4j ? "${var.data_path}/neo4j" : null
    mongodb    = var.enable_mongodb ? "${var.data_path}/mongodb" : null
  }
}

# Summary output for quick reference
output "deployment_summary" {
  description = "Summary of all deployed databases"
  value = join("\n", [
    "=== DEPLOYED DATABASES ===",
    var.enable_redis ? "✓ Redis: localhost:${var.redis_port}" : "✗ Redis: Not deployed",
    var.enable_postgresql ? "✓ PostgreSQL: localhost:${var.postgres_port}" : "✗ PostgreSQL: Not deployed",
    var.enable_mysql ? "✓ MySQL: localhost:${var.mysql_port}" : "✗ MySQL: Not deployed",
    var.enable_sqlserver ? "✓ SQL Server: localhost:${var.sqlserver_port}" : "✗ SQL Server: Not deployed",
    var.enable_cassandra ? "✓ Cassandra: localhost:${var.cassandra_port}" : "✗ Cassandra: Not deployed",
    var.enable_neo4j ? "✓ Neo4j: http://localhost:${var.neo4j_http_port}" : "✗ Neo4j: Not deployed",
    var.enable_mongodb ? "✓ MongoDB: localhost:${var.mongodb_port}" : "✗ MongoDB: Not deployed",
    "",
    "Use 'terraform output connection_info' for detailed connection strings",
    "Use 'terraform output database_urls' for CLI commands"
  ])
}
