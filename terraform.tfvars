# terraform.tfvars
environment = "dev"
data_path   = "./data"

# Habilitar solo las bases de datos que necesites
enable_redis      = true
enable_postgresql = true
enable_mysql      = true
enable_sqlserver  = false

# Configuración de puertos (evitar conflictos)
redis_port     = 6379
postgres_port  = 5432
mysql_port     = 3306
sqlserver_port = 1433

# Passwords (cambiar en producción)
redis_password     = "1234"
postgres_password  = "1234"
mysql_password     = "1234"
sqlserver_password = "MySecurePassword123!"