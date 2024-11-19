#!/bin/bash

ansible_image="ansible_pod:9.5.1"

podman run --rm --volume ${PWD}:/pwd --workdir /pwd \
  $ansible_image "$@"
