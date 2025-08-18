# terraform.tfvars
environment = "dev"
data_path   = "./data"

# Habilitar solo las bases de datos que necesites
enable_redis      = true
enable_postgresql = true
enable_mysql      = true
enable_sqlserver  = false
enable_mongodb    = false
enable_cassandra  = false
enable_neo4j      = false

# Habilitar clientes web
enable_web_clients = true

# Configuración de puertos (evitar conflictos)
redis_port     = 6379
postgres_port  = 5432
mysql_port     = 3306
sqlserver_port = 1433
mongodb_port   = 27017
cassandra_port = 9042
neo4j_http_port = 7474
neo4j_bolt_port = 7687

# Puertos de clientes web
phpmyadmin_port      = 8080
pgadmin_port         = 8081
redis_commander_port = 8082
mongo_express_port   = 8083

# Passwords (cambiar en producción)
redis_password     = "1234"
postgres_password  = "1234"
postgres_username  = "postgres"
postgres_db_name   = "testdb"
mysql_password     = "1234"
mysql_db_name      = "testdb"
sqlserver_password = "MySecurePassword123!"
mongodb_username   = "admin"
mongodb_password   = "admin123"
mongodb_database   = "testdb"
cassandra_cluster_name = "TestCluster"
neo4j_password     = "neo4j123"

# Configuración de clientes web
pgadmin_email      = "admin@localhost.com"
pgadmin_password   = "admin123"
mongo_express_user = "admin"
mongo_express_password = "pass"