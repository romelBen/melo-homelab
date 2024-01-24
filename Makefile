.POSIX:
.PHONY: *
.EXPORT_ALL_VARIABLES:

KUBECONFIG = $(shell pwd)/metal/kubeconfig.yaml
KUBE_CONFIG_PATH = $(KUBECONFIG)

default: metal bootstrap external smoke-test post-install clean

configure:
	./scripts/configure
	git status

metal:
	make -C metal

bootstrap:
	make -C bootstrap

external:
	make -C external

smoke-test:
	make -C test filter=Smoke

post-install:
	@./scripts/hacks

tools:
	@docker run \
		--rm \
		--interactive \
		--tty \
		--network host \
		--env "KUBECONFIG=${KUBECONFIG}" \
		--volume "/var/run/docker.sock:/var/run/docker.sock" \
		--volume $(shell pwd):$(shell pwd) \
		--volume ${HOME}/.ssh:/root/.ssh \
		--volume ${HOME}/.terraform.d:/root/.terraform.d \
		--volume homelab-tools-cache:/root/.cache \
		--volume homelab-tools-nix:/nix \
		--workdir $(shell pwd) \
		docker.io/nixos/nix nix --experimental-features 'nix-command flakes' develop

test:
	make -C test

clean:
	docker compose --project-directory ./metal/roles/pxe_server/files down

dev:
	make -C metal cluster env=dev
	make -C bootstrap

docs:
	mkdocs serve

git-hooks:
	pre-commit install

default: boot cluster

~/.ssh/id_ed25519:
	ssh-keygen -t ed25519 -P '' -f "$@"

# boot: ~/.ssh/id_ed25519
# 	ansible-playbook \
# 		--inventory inventories/${env}.yml= \
# 		boot.yml

setup-k3s-cluster:
	cd ~/melo-homelab/metal/roles/k3s; \
	ansible all -i inventory/melo-homelab-cluster/hosts.ini -m ping; \
	ansible-playbook site.yml -i inventory/melo-homelab-cluster/hosts.ini;

remove-k3s-cluster:
	cd ~/melo-homelab/metal/roles/k3s; \
	ansible all -i inventory/melo-homelab-cluster/hosts.ini -m ping; \
	ansible-playbook reset.yml -i inventory/melo-homelab-cluster/hosts.ini;

reboot-k3s-cluster:
	cd ~/melo-homelab/metal/roles/k3s; \
	ansible all -i inventory/melo-homelab-cluster/hosts.ini -m ping; \
	ansible-playbook reboot.yml -i inventory/melo-homelab-cluster/hosts.ini;