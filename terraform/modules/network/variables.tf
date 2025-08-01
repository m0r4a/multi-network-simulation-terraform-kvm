variable "network_name" {
  description = "Name of the network"
  type        = string
}

variable "bridge_name" {
  description = "Name of the bridge interface"
  type        = string
}

variable "network_cidr" {
  description = "CIDR block for the network"
  type        = string
}
