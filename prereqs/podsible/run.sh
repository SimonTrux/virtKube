#!/bin/bash

ansible_image="$1"

podman run --rm --volume ${PWD}:/pwd --workdir /pwd \
  $ansible_image ansible
