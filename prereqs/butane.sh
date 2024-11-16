#!/bin/bash

## add this to aliases if you want it for later
#alias butane='podman run --rm --interactive       \
#              --security-opt label=disable        \
#              --volume ${PWD}:/pwd --workdir /pwd \
#              quay.io/coreos/butane:release'

mkdir -p ./butane

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
EOF

podman run --rm --interactive       \
--security-opt label=disable        \
--volume ${PWD}:/pwd --workdir /pwd \
quay.io/coreos/butane:release \
--pretty --strict -d ./butane butane/$1.bu --output butane/$1.ign
