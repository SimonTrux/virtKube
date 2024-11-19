# DATA
vm_list := "fcos01"
sshkey_list := "core_key kube_key"
work_dir := "./butane"

# Tools
ansible_img := "ansible_pod:9.5.1"

## All section
all: prereqs install status

## PREREQS SECTION

prereqs: pkgs butane

pkgs:
	./prereqs/packages.sh

os-image:
	./prereqs/os_image.sh

keys:
	./prereqs/ssh_key_pair.sh ${sshkey_list} ${work_dir}

butane: keys
	./prereqs/butane.sh ${vm_list} ${work_dir}

build-ansible:
	./prereqs/podsible/build.sh ${ansible_img}

ansible: build-ansible
	./prereqs/podsible/run.sh ${ansible_img}


## INSTALL SECTION

## Need to split install from the setup
install: butane
	scripts/install_vm.sh ${vm_list}

## Actions
start:
	scripts/manipulate_vm.sh ${vm_list} start
shutdown:
	scripts/manipulate_vm.sh ${vm_list} shutdown
reboot:
	scripts/manipulate_vm.sh ${vm_list} reboot
pause:
	scripts/manipulate_vm.sh ${vm_list} suspend
resume:
	scripts/manipulate_vm.sh ${vm_list} resume


## Once running

status:
	sudo virsh list
	sudo virsh net-dhcp-leases default


## CLEANUP

# Remove VMs, snapshots and storage.
remove:
	scripts/remove_all_storage.sh ${vm_list}

# Clean working directory
clean:
	rm -rf ${work_dir}

