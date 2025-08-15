output "address" {
  description = "Main IP of the VM"
  value       = var.network_interfaces[0].address
}
