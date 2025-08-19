# Configuración del proyecto
environment  = "production"
project_name = "database-infrastructure"

# Configuración de MySQL
mysql_version       = "8.0"
mysql_root_password = "SuperSecureRootPassword123!"
mysql_database      = "main_database"
mysql_user          = "dbadmin"
mysql_password      = "SecureAdminPassword123!"
mysql_external_port = 3306

# Configuración de phpMyAdmin
phpmyadmin_version       = "latest"
phpmyadmin_external_port = 8080

# Configuración de ngrok
ngrok_version   = "latest"
ngrok_authtoken = "1dxpB1SxTDiLGGS6FxxKjiPyXTE_5dgyzUfMV23w6D7ebYbd1"
ngrok_region    = "us"
ngrok_domain    = "" # Deja vacío para dominio automático

# Configuración de red
network_subnet = "172.20.0.0/16"

ngrok_tunnel_target = "database-infrastructure-phpmyadmin:80"
