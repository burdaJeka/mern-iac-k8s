# ==============================================================================
# Provider Configuration
# ==============================================================================
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# ==============================================================================
# Network Layer
# Creates a dedicated isolated network for all MERN components
# ==============================================================================
resource "docker_network" "mern_net" {
  name = "mern_internal_network"
}

# ==============================================================================
# Modules Integration (Infrastructure Lego Blocks)
# ==============================================================================

# 1. Database Module (MongoDB)
module "database" {
  source       = "../../modules/database"
  db_password  = var.db_password
  network_name = docker_network.mern_net.name
}

# 2. Backend Module (Node.js API)
module "backend" {
  source       = "../../modules/backend"
  db_password  = var.db_password
  network_name = docker_network.mern_net.name
}

# 3. Frontend Module (Web Server)
module "frontend" {
  source        = "../../modules/frontend"
  network_name  = docker_network.mern_net.name
  external_port = 8080 # Port exposed to the host machine
}
