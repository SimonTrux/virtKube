#!/bin/bash

echo -e "\nPulling Fedora CoreOS image\n"

mkdir -p ./os_img

STREAM="stable"

# from a container
podman run --pull=newer --rm \
	-v os_img/:/data -w /data \
    quay.io/coreos/coreos-installer:release \
		download -s "${STREAM}" -p qemu -f qcow2.xz --decompress
