#!/bin/bash

## add this to aliases if you want it for later
#alias butane='podman run --rm --interactive       \
#              --security-opt label=disable        \
#              --volume ${PWD}:/pwd --workdir /pwd \
#              quay.io/coreos/butane:release'



podman run --rm --interactive       \
--security-opt label=disable        \
--volume ${PWD}:/pwd --workdir /pwd \
quay.io/coreos/butane:release \
--pretty --strict -d . $1.bu --output $1.ign
