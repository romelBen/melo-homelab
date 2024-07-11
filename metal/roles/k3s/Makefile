.POSIX:
.PHONY: k3s-setup k3s-reset

k3s-setup:
	ansible-playbook site.yml -i inventory/melo-homelab/prod.yml -k

k3s-reset:
	ansible-playbook reset.yml -i inventory/melo-homelab/prod.yml -k