#!/bin/bash

## add this to aliases if you want it for later
#alias butane='podman run --rm --interactive       \
#              --security-opt label=disable        \
#              --volume ${PWD}:/pwd --workdir /pwd \
#              quay.io/coreos/butane:release'

vm_list="$1"
sshkey_list="$2"
butane_dir="$3"
# == ./butane

# turning sshkey_list into an array
sshkey_array=()
for key in ${sshkey_list}
do
  sshkey_array+=("${key}")
done


mkdir -p ${butane_dir}


for vm in ${vm_list}
do

echo "Creating all VMs files butane/${vm}.bu"

cat << EOF > ./butane/${vm}.bu
variant: fcos
version: 1.5.0
passwd:
  users:
    - name: core
      ssh_authorized_keys_local:
        - ${sshkey_array[0]}.pub
      groups:
        - wheel
      shell: /bin/bash
    - name: kube
      ssh_authorized_keys_local:
        - ${sshkey_array[1]}.pub
      shell: /bin/bash
storage:
  files:
    - path: /etc/hostname
      mode: 0644
      contents:
        inline: ${vm}
EOF

echo "Converting into ${butane_dir}/${vm}.ign"

podman run --rm --interactive       \
--security-opt label=disable        \
--volume ${PWD}:/pwd --workdir /pwd \
quay.io/coreos/butane:release \
--pretty --strict -d ${butane_dir} ${butane_dir}/${vm}.bu --output ${butane_dir}/${vm}.ign

done

