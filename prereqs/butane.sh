#!/bin/bash

## add this to aliases if you want it for later
#alias butane='podman run --rm --interactive       \
#              --security-opt label=disable        \
#              --volume ${PWD}:/pwd --workdir /pwd \
#              quay.io/coreos/butane:release'

echo "Creating butane director."
mkdir -p ./butane

echo "Creating butane/$1.bu"
cat << EOF > ./butane/$1.bu
variant: fcos
version: 1.5.0
passwd:
  users:
    - name: core
      ssh_authorized_keys_local:
        - $1.pub
      groups:
        - wheel
      shell: /bin/bash
storage:
  files:
    - path: /etc/hostname
      mode: 0644
      contents:
        inline: $1
EOF

echo "Creating butane/$1.ign"

podman run --rm --interactive       \
--security-opt label=disable        \
--volume ${PWD}:/pwd --workdir /pwd \
quay.io/coreos/butane:release \
--pretty --strict -d ./butane butane/$1.bu --output butane/$1.ign
