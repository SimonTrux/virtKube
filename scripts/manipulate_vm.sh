#!/bin/bash

source vm_list.sh

for vm in $vm_list ; do
  sudo virsh $1 $vm
done
