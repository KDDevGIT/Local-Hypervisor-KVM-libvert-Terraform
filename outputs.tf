output "vm_names" {
  value = [for d in libvirt_domain.vm : d.name]
}

output "vm_ips" {
  value = {
    for d in libvirt_domain.vm : d.name => try(d.network_interface[0].addresses, [])
  }
}