terraform {
  required_version = ">= 1.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.5.0"
    }
    ngrok = {
      source  = "ngrok/ngrok"
      version = "0.4.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
