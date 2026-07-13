terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

resource "docker_image" "mongo" {
  name         = "mongo:latest"
  keep_locally = true
}

resource "docker_volume" "mongo_data" {
  name = "mern_mongo_data"
}

resource "docker_container" "mongodb" {
  name  = "mongodb"
  image = docker_image.mongo.image_id

  networks_advanced {
    name = var.network_name
  }

  volumes {
    volume_name    = docker_volume.mongo_data.name
    container_path = "/data/db"
  }

  env = [
    "MONGO_INITDB_ROOT_USERNAME=admin",
    "MONGO_INITDB_ROOT_PASSWORD=${var.db_password}"
  ]
}
