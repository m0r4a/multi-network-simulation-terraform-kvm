terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "~> 0.8.3"
    }
  }
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
    xslt = file("${path.module}/.cdrom-model.xsl")
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
