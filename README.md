# Terraform + libvirt Local Hypervisor (Linux VM)

[![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![KVM](https://img.shields.io/badge/KVM-QEMU-red?style=for-the-badge&logo=linux&logoColor=white)](https://www.linux-kvm.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)

Spin up and manage multiple **Ubuntu cloud-image VMs** on a single Linux host using **Infrastructure as Code**.  

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
```
## Quick Start
```bash
git clone https://github.com/<your-user>/terraform-libvirt-lab.git
cd terraform-libvirt-lab
cp terraform.tfvars.example terraform.tfvars
# (edit vm_count, memory, CPU, ssh key, etc.)
```
## Build Lab
```bash
terraform init
terraform apply -auto-approve
```
## Get IPs
```bash
terraform output vm_ips
```
## SSH into VM
```bash
ssh ubuntu@<ip>
```
## Scale/Tear Down in Terraform
```bash
# adjust vm_count in terraform.tfvars, then:
terraform apply -auto-approve

# destroy lab:
terraform destroy -auto-approve
```
## Configuration Options
| Variable              | Default                 | Description                       |
| --------------------- | ----------------------- | --------------------------------- |
| `vm_count`            | `2`                     | Number of VMs to create           |
| `vm_name_prefix`      | `lab`                   | VM name prefix                    |
| `memory_mb`           | `2048`                  | RAM per VM (MB)                   |
| `vcpu`                | `2`                     | vCPUs per VM                      |
| `disk_size_gb`        | `20`                    | Disk size per VM                  |
| `network_name`        | `default`               | Libvirt network (`default` = NAT) |
| `ssh_public_key_file` | `~/.ssh/id_ed25519.pub` | SSH public key path               |
| `image_url`           | Ubuntu 24.04 LTS        | Base cloud image URL              |

# Example
```bash
ssh ubuntu@192.168.122.103 #lab-1
# first connect: type 'yes', no password needed (SSH key injected)
```
## Inside the VM:
```bash
uname -a
systemctl is-active qemu-guest-agent
ip -4 a
```
## If qemu-guest-agent isn't active
```bash
sudo systemctl enable --now qemu-guest-agent
```
## To Install Desktop + VNC Server in VM
```bash
# FOR XFCE (Light, Recommended)
sudo apt update
sudo apt install -y xfce4 xfce4-goodies tightvncserver
```
## GNOME (Heavy Option)
```bash
sudo apt install -y ubuntu-desktop
```
## Install Graphical Display Manager (lightDM)
```bash
sudo apt install -y lightdm
sudo systemctl enable lightdm
sudo reboot
```
## VNC to :0 and you’ll get the XFCE login screen.
```bash
virsh -c qemu:///system vncdisplay lab-1
Should Print: :0
```



