resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "web" {
  name  = var.docker_container_name
  image = docker_image.nginx.latest
  env   = []

  ports {
    external = 8081
    internal = 80
  }
}
