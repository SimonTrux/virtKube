#!/bin/bash

vm_list=$1

for vm in $vm_list ; do
  sudo virsh undefine --domain $vm --delete-snapshots --remove-all-storage
done
