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
  default     = 1024
}

variable "vcpu" {
  description = "Number of virtual CPUs"
  type        = number
  default     = 2
}

variable "autostart" {
  description = "Autostart the VM"
  type        = bool
  default     = false
}

variable "cloudinit_file" {
  description = "Name of the cloudinit file"
  type        = string
  default     = "cloud_init.cfg"
}

variable "cloudinit_network" {
  description = "Name of the cloudinit network file"
  type        = string
  default     = "network.cfg"
}

variable "network_interfaces" {
  type = list(object({
    bridge  = string
    address = string
    cidr    = string
    gateway = optional(string, "")
  }))

  description = "Config for every interface"
}

variable "ssh_private_key" {
  description = "Private key for ssh"
  type        = string
  default     = ""
  sensitive   = true
}

variable "ssh_public_key" {
  description = "Public key for ssh"
  type        = string
  default     = ""
}

