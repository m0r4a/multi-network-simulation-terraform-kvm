resource "libvirt_volume" "vm_disk" {
  name           = "${var.vm_name}-disk"
  base_volume_id = var.base_volume_id
  size           = var.disk_size
  format         = "qcow2"
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name      = "commoninit.iso"
  user_data = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
}

data "template_file" "user_data" {
  template = file("${path.module}/cloudinit_files/cloud_init.cfg")

}

data "template_file" "network_config" {
  template = file("${path.module}/cloudinit_files/network.cfg")

  vars = {
    ip_address = var.ip_address
    mask       = var.mask
  }
}
