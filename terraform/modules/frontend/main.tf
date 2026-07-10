terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

resource "docker_image" "frontend" {
  name         = "nginx:alpine"
  keep_locally = true
}

resource "docker_container" "frontend" {
  name  = "mern_frontend"
  image = docker_image.frontend.image_id

  networks_advanced {
    name = var.network_name
  }

  ports {
    internal = 80
    external = var.external_port
  }
}
