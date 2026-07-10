variable "db_password" {
  description = "Password for MongoDB"
  type        = string
  sensitive   = true
}

variable "network_name" {
  description = "Name of Docker-network"
  type        = string
}
