variable "network_name" {
  description = "Name of Docker-network"
  type        = string
}

variable "external_port" {
  description = "Outside port"
  type        = number
  default     = 8080 # By default
}
