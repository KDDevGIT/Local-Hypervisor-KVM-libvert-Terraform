variable "libvirt_uri" {
  type = string
  default = "qemu:///system"
  description = "libvirt connection URI"
}
provider "libvirt" {
  uri = var.libvirt_uri
}