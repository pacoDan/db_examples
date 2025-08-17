terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "sqlserver" {
  count = var.enabled ? 1 : 0  # ← AGREGAR ESTA LÍNEA
  name = "mcr.microsoft.com/mssql/server:${var.sqlserver_version}"
   # Evita que la imagen se borre al hacer destroy
  keep_locally = true
}

resource "docker_container" "sqlserver" {
  count = var.enabled ? 1 : 0
  image = docker_image.sqlserver[0].image_id
  name  = "${var.environment}-sqlserver-${var.instance_name}"

  ports {
    internal = 1433
    external = var.external_port
  }
  # Comentar volúmenes temporalmente para evitar problemas de permisos
  # volumes {
  #   host_path      = abspath("${var.data_path}/sqlserver/data")
  #   container_path = "/var/opt/mssql/data"
  # }
  # 
  # volumes {
  #   host_path      = abspath("${var.data_path}/sqlserver/log")
  #   container_path = "/var/opt/mssql/log"
  # }
  # 
  # volumes {
  #   host_path      = abspath("${var.data_path}/sqlserver/secrets")
  #   container_path = "/var/opt/mssql/secrets"
  # }
  env = [
    "ACCEPT_EULA=Y",
    "SA_PASSWORD=${var.sa_password}",
    "MSSQL_PID=${var.edition}",
    "MSSQL_COLLATION=${var.collation}"
  ]

  memory = var.memory_limit
  restart = "unless-stopped"

  healthcheck {
    test = ["/opt/mssql-tools/bin/sqlcmd", "-S", "localhost", "-U", "sa", "-P", "${var.sa_password}", "-Q", "SELECT 1"]
    interval = "30s"
    timeout = "10s"
    retries = 5
    start_period = "60s"
  }
}

resource "null_resource" "create_database" {
  count = var.enabled && var.initial_database != "" ? 1 : 0

  depends_on = [docker_container.sqlserver]

  provisioner "local-exec" {
    command = <<-EOT
      sleep 30
      docker exec ${docker_container.sqlserver[0].name} /opt/mssql-tools/bin/sqlcmd \
        -S localhost -U sa -P "${var.sa_password}" \
        -Q "CREATE DATABASE [${var.initial_database}]"
    EOT
  }

  triggers = {
    container_id = var.enabled ? docker_container.sqlserver[0].id : ""
    database_name = var.initial_database
  }
}