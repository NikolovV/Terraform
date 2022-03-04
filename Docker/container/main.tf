terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.13.0"
    }
  }
}

provider "docker" {
  host    = "npipe:////.//pipe//docker_engine"
}

resource "docker_image" "httpd" {
  name         = "httpd:latest"
  keep_locally = false
}

resource "docker_container" "httpd" {
  image = docker_image.httpd.latest
  name  = "docker_terraform"
  ports {
    internal = 80
    external = 8000
  }
}

output "container_id" {
  description = "ID of the Docker container"
  value       = docker_container.httpd.id
}
