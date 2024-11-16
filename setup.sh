#!/bin/bash

#prereqs/packages.sh
#prereqs/os_image.sh

vm_list="fcos01"

for vm in $vm_list
do
  prereqs/ssh_key_pair.sh $vm
# prereqs/butane.sh $vm
done

