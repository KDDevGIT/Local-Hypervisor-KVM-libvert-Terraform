variable "pool" {
    type = string
    default = "default"
}

variable "vm_count" {
    type = number
    default = 2
}

variable "vm_name_prefix" {
    type = string
    default = "lab"
}

variable "memory_mb" {
  type = number
  default = 2048
}

variable "vcpu" {
    type = number
    default = 2
}

variable "disk_size_gb" {
  type = number
  default = 20
}

variable "network_name" {
  type = string
  default = "default"
}

variable "ssh_public_key_file" {
  type = string
  default = "~/.ssh/id_ed25519.pub"
}

variable "image_url" {
  type = string
  default = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  description = "Ubuntu 24.04 LTS Cloud Image"
}

