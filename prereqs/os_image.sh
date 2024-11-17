#!/bin/bash

echo -e "\nPulling Fedora CoreOS image\n"

STREAM="stable"

# from a container
podman run --pull=newer --rm \
	-v $HOME/.local/share/libvirt/images/:/data -w /data \
    quay.io/coreos/coreos-installer:release \
		download -s "${STREAM}" -p qemu -f qcow2.xz --decompress
