#!/bin/bash

vm_list=$1

## TODO : Ask for confirmation

for vm in $vm_list ; do
# sudo virsh undefine --domain $vm --delete-snapshots --remove-all-storage
  sudo virsh shutdown --domain $vm && sudo virsh undefine --domain $vm
  sleep 1
  echo "Storage /var/lib/libvirt/images/$vm.qcow2 is being removed."
  sudo rm /var/lib/libvirt/images/${vm}.qcow2
done
