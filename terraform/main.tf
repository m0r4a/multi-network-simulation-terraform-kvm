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

locals {
  private_key = file("${path.root}/.ssh/ansible_key")
  public_key  = file("${path.root}/.ssh/ansible_key.pub")
  my_public_key = file("~/.ssh/id_rsa.pub")
}

module "gateway" {
  source = "./modules/vm"
  vm_name = "gateway"
  memory         = 1024
  vcpu           = 1
 
  base_volume_id = libvirt_volume.rocky_linux.id

  cloudinit_file  = "gateway_init.cfg"
  ssh_private_key = local.private_key
  ssh_public_key  = local.my_public_key

  network_interfaces = [
  { bridge = "br-admin", address = "10.0.0.1",   cidr = "30"},
  { bridge = "br-user",  address = "10.0.1.1",   cidr = "24"},
  { bridge = "virbr0",   address = "192.168.100.2", cidr = "24"}
  ]
}

module "admin" {
  source = "./modules/vm"
  vm_name = "admin"
  memory         = 512
  vcpu           = 1
 
  base_volume_id = libvirt_volume.rocky_linux.id
  ssh_public_key = local.public_key

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
  ssh_public_key = local.public_key

  network_interfaces = [
  { bridge = "br-user", address = "10.0.1.100", cidr = "24", gateway = "10.0.1.1"}
  ]
}
