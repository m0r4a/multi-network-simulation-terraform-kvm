provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_volume" "rocky_linux" {
  name = "rocky_linux"
  source = "/var/lib/libvirt/images/Rocky-10-cloud.qcow2"
}

module "admin_network" {
  source = "./modules/network"
  network_name = "admin-net"
  bridge_name = "br-admin"
  network_cidr = "10.0.0.0/24"
}

module "gateway" {
  source = "./modules/vm"
  vm_name = "gateway"
  autostart = true
  memory         = 2048
  vcpu           = 4
 
  base_volume_id = libvirt_volume.rocky_linux.id

  ip_address = "10.0.0.2"
  mask = "255.255.255.252"
  network_id = module.admin_network.id
}
