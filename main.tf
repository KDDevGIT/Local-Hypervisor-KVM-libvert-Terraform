resource "libvirt_volume" "ubuntu_base" {
    name = "ubuntu-nobile-base.img"
    pool = var.pool
    source = var.image_url
}

resource "libvirt_cloudinit_disk" "cidata" {
  count = var.vm_count
  name = "${var.vm_name_prefix}-${count.index + 1}-seed.iso"
  user_data = templatefile("${path.module}/cloudinit/user-data.tpl", {
    hostname = "${var.vm_name_prefix}-${count.index + 1}"
    ssh_authorized_key = local.ssh_pubkey
  })
}

resource "libvirt_volume" "vm_disk" {
  count = var.vm_count
  name = "${var.vm_name_prefix}-${count.index + 1}.qcow2"
  pool = var.pool
  base_volume_id = libvirt_volume.ubuntu_base.id 
  format = "qcow2"
  size = local.disk_size_bytes
}

resource "libvirt_domain" "vm" {
  count = var.vm_count
  name = "${var.vm_name_prefix}-${count.index + 1}"
  memory = var.memory_mb
  vcpu = var.vcpu

  cpu { mode = "host-passthrough" }
  qemu_agent = true

  network_interface {
    network_name = var.network_name
    wait_for_lease = true
  }

  disk { volume_id = libvirt_volume.vm_disk[count.index].id }
  cloudinit = libvirt_cloudinit_disk.cidata[count.index].id

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "vnc"
    listen_type = "address"
    autoport = true
  }
}