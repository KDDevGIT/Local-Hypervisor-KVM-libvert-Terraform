# Terraform + libvirt Local Hypervisor Lab

[![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![KVM](https://img.shields.io/badge/KVM-QEMU-red?style=for-the-badge&logo=linux&logoColor=white)](https://www.linux-kvm.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)

Spin up and manage multiple **Ubuntu cloud-image VMs** on a single Linux host using **Infrastructure as Code**.  
This lab is great for **cloud engineers, DevOps learners, and homelab enthusiasts** who want a repeatable way to practice virtualization fundamentals.

---

## Features
- **Terraform + libvirt provider** – declarative VM management
- **Cloud-init automation** – SSH key injection & guest agent install
- **Dynamic scaling** – adjust `vm_count` to add/remove VMs instantly
- **NAT networking** via libvirt `default` network (`virbr0`)
- **Outputs** for VM names & IPs for quick SSH access
- **Ubuntu 24.04 LTS** cloud image (switchable to 22.04 if preferred)

---

## Prerequisites (Ubuntu/Debian host)

```bash
sudo apt update
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst virt-manager cloud-image-utils
sudo usermod -aG libvirt,kvm $USER
newgrp libvirt
sudo systemctl enable --now libvirtd
virsh net-start default || true
virsh net-autostart default || true

