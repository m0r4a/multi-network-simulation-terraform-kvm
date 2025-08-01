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
  template = file("${path.module}/cloud_init.cfg")
}

data "template_file" "network_config" {
  template = file("${path.module}/network.cfg")
}

resource "libvirt_domain" "vm" {
  name       = var.vm_name
  memory     = var.memory
  vcpu       = var.vcpu
  autostart  = var.autostart
  machine   = "q35"
  qemu_agent = true
  cloudinit = libvirt_cloudinit_disk.commoninit.id

  xml {
    xslt = file("${path.module}/cdrom-model.xsl")
  }

  disk {
    volume_id = libvirt_volume.vm_disk.id
  }
  
  network_interface {
    hostname       = var.vm_name
    network_id     = var.network_id
    addresses      = [var.ip_address]
  }

  cpu {
    mode = "host-passthrough"
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }
  
  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }
  
  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
