para ver la URL de ngrok
```sh
docker logs database-infrastructure-ngrok
```
tip profesional en entorno productivos: mariadb -h 127.0.0.1 -P 3306 -u root -p
```sql
docker exec -it database-infrastructure-mysql mysql -uroot -p
ALTER USER 'root'@'%' IDENTIFIED BY 'NuevaPassword123!';
```
tip dev para parar el contenedor y eliminar el volumen:
```sh
docker rm -f database-infrastructure-mysql
docker volume rm database-infrastructure-mysql-data
terraform apply -auto-approve
```
para probar redis:
```sh
docker exec -it database-infrastructure-redis redis-cli
```




---

habria que mover los .tfvars dentro de la carpeta environments
```sh
# Para desarrollo
terraform apply -var-file="environments/dev.tfvars"
# Para producción
terraform apply -var-file="environments/prod.tfvars"
```
variables.tf: Define la estructura y metadatos de las variables
terraform.tfvars: Proporciona los valores específicos para un entorno

# Aplicar los cambios
```sh
terraform apply -auto-approve
```

comandos  de uso rapido:
```sh
# Desplegar solo MySQL
terraform apply -target=module.mysql

# Desplegar solo SQL Server
terraform apply -target=module.sqlserver

# Desplegar múltiples bases específicas
terraform apply -target=module.mysql -target=module.redis

# Destruir una base específica
terraform destroy -target=module.sqlserver

# Ver el estado de todos los recursos
terraform state list
```

---
```sh
# Limpiar archivos de estado si existen
rm -rf .terraform*
rm -f terraform.tfstate*

# Crear directorios de datos
mkdir -p data/{redis,postgres,mysql,sqlserver,cassandra,mongodb,neo4j}

# Inicializar Terraform
terraform init

# Validar configuración
terraform validate

# Ver plan
terraform plan
```