variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "base_volume_id" {
  description = "Base volume ID for the VM"
  type        = string
}

variable "disk_size" {
  description = "Disk size in bytes"
  type        = number
  default     = 21474836480 # 20GB
}

variable "memory" {
  description = "Memory allocation in MB"
  type        = number
  default     = 2048
}

variable "vcpu" {
  description = "Number of virtual CPUs"
  type        = number
  default     = 2
}

variable "autostart" {
  description = "Autostart the VM"
  type        = bool
  default     = true
}

variable "network_id" {
  description = "Network ID to attach the VM"
  type        = string
}

variable "ip_address" {
  description = "Static IP address for the VM"
  type        = string
}
