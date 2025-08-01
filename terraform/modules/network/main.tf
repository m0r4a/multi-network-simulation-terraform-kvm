resource "libvirt_network" "network" {

  name = var.network_name
  mode = "bridge"
  bridge = var.bridge_name
  addresses = [var.network_cidr]

}

