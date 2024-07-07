.POSIX:

env ?= prod
export KUBECONFIG = $(shell pwd)/metal/roles/k3s/kubeconfig.yaml

default: boot cluster
# default: cluster

~/.ssh/id_ed25519:
	ssh-keygen -t ed25519 -P '' -f "$@"

# boot: ~/.ssh/id_ed25519
# 	ansible-playbook \
# 		--inventory inventories/${env}.yml \
# 		boot.yml

cluster:
	ansible-playbook --inventory inventories/${env}.yml cluster.yml -k

console:
	ansible-console \
		--inventory inventories/${env}.yml