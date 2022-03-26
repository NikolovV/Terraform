terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.11"
    }
  }
  required_version = ">= 0.14"
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}