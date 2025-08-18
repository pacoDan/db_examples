habria que mover los .tfvars dentro de la carpeta environments
```sh
# Para desarrollo
terraform apply -var-file="environments/dev.tfvars"
# Para producción
terraform apply -var-file="environments/prod.tfvars"
```
variables.tf: Define la estructura y metadatos de las variables
terraform.tfvars: Proporciona los valores específicos para un entorno
# Crear todos los directorios de datos
```sh
mkdir -p data/{redis,postgres,mysql,sqlserver/{data,log,secrets},cassandra,mongodb,neo4j/{data,logs}}
```
# Aplicar los cambios
```sh
terraform apply -auto-approve
```
estructura del proyecto:
```txt
terraform-databases/
├── modules/
│   ├── redis/
│   ├── sqlserver/
│   ├── postgresql/
│   ├── mysql/
│   ├── cassandra/
│   ├── neo4j/
│   └── mongodb/
├── environments/
│   ├── dev/
│   ├── test/
│   └── prod/
├── main.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars
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