terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

resource "docker_image" "backend_api" {
  name         = "mendhak/http-https-echo:30"
  keep_locally = true
}

resource "docker_container" "backend" {
  name  = "mern_backend"
  image = docker_image.backend_api.image_id

  networks_advanced {
    name = var.network_name
  }

  env = [
    "MONGO_URL=mongodb://admin:${var.db_password}@mongodb:27017"
  ]
}
