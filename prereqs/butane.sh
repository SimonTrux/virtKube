#!/bin/bash

## add this to aliases if you want it for later
#alias butane='podman run --rm --interactive       \
#              --security-opt label=disable        \
#              --volume ${PWD}:/pwd --workdir /pwd \
#              quay.io/coreos/butane:release'

vm_list="$1"
butane_dir="$2"  # ./butane
mkdir -p ${butane_dir}

ip_last_digit=99


for vm in ${vm_list}
do

((ip_last_digit+= 1))

echo "Creating all VMs files butane/${vm}.bu"

cat << EOF > ./butane/${vm}.bu
variant: fcos
version: 1.5.0
passwd:
  users:
    - name: core
      ssh_authorized_keys_local:
        - core_key.pub
      groups:
        - wheel
      shell: /bin/bash
    - name: kuber
      ssh_authorized_keys:
        - "$(cat ${butane_dir}/kube_key.pub)"
storage:
  directories:
    - path: /var/cache/rpm-ostree-install
  files:
    - path: /etc/hostname
      mode: 0644
      contents:
        inline: ${vm}
    - path: /etc/NetworkManager/system-connections/static-enp1s0.nmconnection
      mode: 0600
      contents:
        inline: |
          [connection]
          id=static-enp1s0
          type=ethernet
          interface-name=enp1s0
          autoconnect=true

          [ipv4]
          method=manual
          addresses=192.168.124.${ip_last_digit}/24
          gateway=192.168.124.1
          dns=8.8.8.8;8.8.4.4;

          [ipv6]
          method=ignore
EOF

echo "Converting into ${butane_dir}/${vm}.ign"

podman run --rm --interactive       \
--security-opt label=disable        \
--volume ${PWD}:/pwd --workdir /pwd \
quay.io/coreos/butane:release \
--pretty --strict -d ${butane_dir} ${butane_dir}/${vm}.bu --output ${butane_dir}/${vm}.ign

done

