# Melo-Homelab
> [!IMPORTANT]
> This project is still a work in-progress. I am still testing out the correct process for services and will udpate when
> ready. This warning will be remove once it's fully operational. Thanks for your cooperation.

Melo is suppose to be my name mix together without an "R", or Melo can be understood with *Merlo* which is a place connected to the enchanting presense of blackbirds has nothing to do with homelabs. So back to what this project is about! This repository includes IaC and GitOps processes using the latest technologies.

## 🔧 Hardware
| Device                                                                                 | Description              | Quantity | CPU     | RAM      | Architecture | Operating System                      |  Notes |
| -------------------------------------------------------------------------------------- | ------------------------ | -------- | ------- | -------- | ------------ | ------------------------------------- | ----- |
| [Unifi Dream Machine Pro SE](https://store.ui.com/us/en/collections/unifi-dream-machine/products/udm-se)                                  | Router                   | 1        | 4 Cores | 4GB RAM | AMD64        | Mystery              |  Not recommended for the faint of heart. TP-Link, Netgear, Cisco, or Grandstream are great alternatives.   |
| [Raspberry Pi 4 Model B](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/) | Kubernetes Control Plane       | 4        | 4 Cores | 8GB RAM  | ARM64        | [Raspberry Pi OS (64 bit)](https://www.raspberrypi.com/software/operating-systems/) |
| [Dell Optiplex MFF](https://www.dell.com/en-us/shop/desktop-computers/optiplex-micro-form-factor/spd/optiplex-7010-micro) | Kubernetes Node(s) | 3 | 6 Cores | 16GB RAM | AMD64 | [Debian Bullseye (11)](https://wiki.debian.org/DebianBullseye) | An issue when buying these on Craigslist or Ebay is there CMOS battery will die. (Happened to me for all 3.) Replace the [CMOS battery](https://www.youtube.com/watch?v=by8XcWZVZB0) so you don't suffer.

## Debian Version History
https://en.wikipedia.org/wiki/Debian_version_history

## Installation of Setup
I have separated the installation process in 2 areas:
- Setup k3s of master and nodes on Raspberry Pi's and Dell Optiplex's respectively.
- Setup all services and do an update, security, and small changes for full capability.

1. To first setup k3s, you will need to be in folder `metal/roles/k3s`:
```shell
cd metal/roles/k3s

# To install k3s on nodes:
ansible-playbook site.yml -i inventory/melo-homelab/hosts.ini -k

# To uninstall k3s on nodes (if an issue or hiccup happens to start from the beginning):
ansible-playbook reset.yml -i inventory/melo-homelab/hosts.ini -k
```

2. Once k3s has been installed successfully, you will need to be in the root directory and run one simple command to have all services fully deployed onto your nodes:
```shell
make
```

3. And presto!

## Acknowledgements
A great inspiration for this project is from [Khue's homelab](https://github.com/khuedoan/homelab). Majority of the changes will be from that project, and my changes will deal with implementing my Raspberry Pis.

In setting up k3s, I took inspiration from Techno Tims repository [k3s-anisble](https://github.com/techno-tim/k3s-ansible).