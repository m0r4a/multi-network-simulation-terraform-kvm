provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_volume" "rocky_linux" {
  name = "rocky_linux"
  source = "/var/lib/libvirt/images/Rocky-10-cloud.qcow2"
}

resource "libvirt_volume" "ubuntu_server" {
  name = "ubuntu_server"
  source = "/var/lib/libvirt/images/ubuntu-noble-24.04.img"
}

module "gateway" {
  source = "./modules/vm"
  vm_name = "gateway"
  memory         = 1024
  vcpu           = 1
 
  base_volume_id = libvirt_volume.rocky_linux.id

  network_interfaces = [
  { bridge = "br-admin", address = "10.0.0.1", cidr = "30"},
  { bridge = "br-user", address = "10.0.1.1", cidr = "24"}
  ]
}


module "admin" {
  source = "./modules/vm"
  vm_name = "admin"
  memory         = 512
  vcpu           = 1
 
  base_volume_id = libvirt_volume.rocky_linux.id

  network_interfaces = [
  { bridge = "br-admin", address = "10.0.0.2", cidr = "30", gateway = "10.0.0.1"}
  ]

}

module "user" {
  source  = "./modules/vm"
  vm_name = "user"
  memory  = 1024
  vcpu    = 1

  base_volume_id = libvirt_volume.ubuntu_server.id

  network_interfaces = [
  { bridge = "br-user", address = "10.0.1.100", cidr = "24", gateway = "10.0.1.1"}
  ]
}
