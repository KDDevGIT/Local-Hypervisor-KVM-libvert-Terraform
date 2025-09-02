#cloud-config
preserve_hostname: false
hostname: ${hostname}
manage_etc_hosts: true

users:
  - name: ubuntu
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, admin
    shell: /bin/bash
    ssh_authorized_keys:
      - ${ssh_authorized_key}

package_update: true
packages:
  - qemu-guest-agent

runcmd:
  - [ systemctl, enable, --now, qemu-guest-agent ]
