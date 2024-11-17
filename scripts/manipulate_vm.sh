#!/bin/bash

vm_list=$1
verb=$2

for vm in $vm_list ; do
  sudo virsh $verb $vm
done
