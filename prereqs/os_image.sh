#!/bin/bash

echo -e "\nPulling Fedora CoreOS image\n"

STREAM="stable"

sudo chown -R $USER: $HOME/.local/share/libvirt/images/

# from a container
podman run --pull=always --rm \
	-v $HOME/.local/share/libvirt/images/:/data -w /data \
    quay.io/coreos/coreos-installer:release \
		download -s "${STREAM}" -p qemu -f qcow2.xz --decompress
