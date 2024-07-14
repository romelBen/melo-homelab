# Melo-Homelab
> [!IMPORTANT]
> This project is still a work in-progress. I am still testing out the correct process for services and will udpate when
> ready. This warning will be remove once it's fully operational. Thanks for your cooperation.

Melo is suppose to be my name mix together without an "R", or Melo can be understood with *Merlo* which is a place connected to the enchanting presense of blackbirds has nothing to do with homelabs. So back to what this project is about! This repository includes IaC and GitOps processes using the latest technologies.

## Tools I Use
- [mise](https://github.com/jdx/mise)(I use this tool as a package manager for different tools such as `terraform`, `python`, `golang`, etc. Think of this tool as a wrapper for [asdf](https://github.com/asdf-vm/asdf).)
- [k9s](https://github.com/derailed/k9s) (k9s is used to interact with k3s. Very easy to use if you know vim.)
- [nix](https://github.com/NixOS/nix)(nix is considered a package manager but I see this as an addon to Docker to make it better. nix does take some time in learning but once mastered, it's a great tool to manage your versioning of projects.)

## 🔧 Hardware
| Device                                                                                 | Description              | Quantity | CPU     | RAM      | Architecture | Operating System                      |  Notes |
| -------------------------------------------------------------------------------------- | ------------------------ | -------- | ------- | -------- | ------------ | ------------------------------------- | ----- |
| [Unifi Dream Machine Pro SE](https://store.ui.com/us/en/collections/unifi-dream-machine/products/udm-se)                                  | Router                   | 1        | 4 Cores | 4GB RAM | AMD64        | Mystery              |  Not recommended for the faint of heart. TP-Link, Netgear, Cisco, or Grandstream are great alternatives.   |
| [Raspberry Pi 4 Model B](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/) | Kubernetes Control Plane       | 4        | 4 Cores | 8GB RAM  | ARM64        | [Raspberry Pi OS (64 bit)](https://www.raspberrypi.com/software/operating-systems/) |
| [Dell Optiplex MFF](https://www.dell.com/en-us/shop/desktop-computers/optiplex-micro-form-factor/spd/optiplex-7010-micro) | Kubernetes Node(s) | 3 | 6 Cores | 16GB RAM | AMD64 | [Debian Bullseye (11)](https://wiki.debian.org/DebianBullseye) | An issue when buying these on Craigslist or Ebay is there CMOS battery will die. (Happened to me for all 3.) Replace the [CMOS battery](https://www.youtube.com/watch?v=by8XcWZVZB0) so you don't suffer.

## Debian Version History
https://en.wikipedia.org/wiki/Debian_version_history

## Installation Setup of Services
I have separated the installation process in 2 areas:
* Setup k3s on Raspberry Pi's (being my `master` nodes) and Dell Optiplex's (being my `nodes`).
* Setup the necessary settings such as `apt-update`/`apt-upgrade`, `ntp`, `ssh`, `sudo`, `pxe_server` (unnecessarry if this was done manually), and security settings to have it secure.

1. To interact with setting/removing k3s, be in the root directory and input the following commands:
```shell

# To install k3s on nodes:
make k3s-setup

# To uninstall k3s on nodes (if an issue or hiccup happens to start from the beginning):
make k3s-reset
```

2. Once installed, you will have k3s setup, kube-vip as the load balancer, and Cilium as the service-mesh!  Before you move forward, it's always best to pull the k3s kube config file to connect. Do the following:
```shell
# Pull kube config file from one of your master nodes
scp ansibleuser@192.168.30.38:~/.kube/config ~/.kube/config

# Then export the vars onto your local environment
export KUBECONFIG= ~/.kube/config
export KUBE_CONFIG_PATH= ~/.kube/config
```

3. Once k3s has been installed successfully, you will need to run one simple command to have all services fully deployed onto your nodes:
```shell
make
```

## Troubleshooting
The Ansible script is not perfect, especially with setting up K3s, kube-vip, and Cilium being added. 
- Cilium will specifically struggle in connecting after 30 attempts to reconnect using the Ansible script. What you will need to do is enter into your cluster and restart the services that are failing. This will be kube-vip and Cilium. (I will need to look into yaml files to restart on failure.)

## Future Enhancements To Add
- [ ] Look into implementing Talos rather than Debian. (Talos has been highly debated if it should be used at all. Talos is API driven and removes `ssh` or access to the nodes themselves.)
- [ ] Give a rundown of each resource that I am utilizing and including it into the README.md
- [ ] I need to find a better way of organizing the deployment. I feel the Makefile's in each directory can be confusing for others.

### Acknowledgements
A great inspiration for this project is from [Khue's homelab](https://github.com/romelben/homelab). Majority of the changes will be from his project, and my changes will deal with implementing my Raspberry Pis as well as small changes.

In setting up k3s, I took inspiration from Techno Tim's repository [k3s-anisble](https://github.com/techno-tim/k3s-ansible) by pruning the unnecessarry code and modifying it to my needs.

A shoutout to [thorian93](https://github.com/thorian93) where I used a couple of Ansible roles to use in my home project.