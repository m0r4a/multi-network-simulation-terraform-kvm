resource "libvirt_volume" "vm_disk" {
  name           = "${var.vm_name}-disk"
  base_volume_id = var.base_volume_id
  size           = var.disk_size
  format         = "qcow2"
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name           = "${var.vm_name}-commoninit.iso"
  user_data      = data.template_file.user_data.rendered

  network_config = templatefile(
    "${path.module}/cloudinit_files/network.cfg",
    {
      interfaces_v2 = var.network_interfaces
    }
  )
}

data "template_file" "user_data" {
  template = file("${path.module}/cloudinit_files/${var.cloudinit_file}")
  vars =  {
    private_key = var.ssh_private_key
    public_key = var.ssh_public_key
  }
}

