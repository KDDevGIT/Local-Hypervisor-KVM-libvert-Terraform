locals {
    ssh_pubkey = chomp(file(pathexpand(var.ssh_public_key_file)))
    disk_size_bytes = var.disk_size_gb * 1024 * 1024 * 1024
}
