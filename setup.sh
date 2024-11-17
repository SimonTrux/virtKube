#!/bin/bash

# Import vm_list var
source ./vm_list.sh

prereqs/packages.sh
prereqs/os_image.sh

for vm in $vm_list
do
  prereqs/ssh_key_pair.sh $vm
  prereqs/butane.sh $vm
  ./install_vm.sh $vm
done

# Print IP of machines
sudo virsh net-dhcp-leases default
