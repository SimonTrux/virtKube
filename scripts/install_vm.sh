#!/bin/bash

vm_list=$1

for vm in $vm_list
do

  IGNITION_CONFIG="${PWD}/butane/${vm}.ign"
  IMAGE="${HOME}/.local/share/libvirt/images/fedora-coreos-41.20241027.3.0-qemu.x86_64.qcow2"

  VM_NAME="${vm}"
  VCPUS="2"
  RAM_MB="2048"
  STREAM="stable"
  DISK_GB="10"

  # For x86 / aarch64,
  IGNITION_DEVICE_ARG=(--qemu-commandline="-fw_cfg name=opt/com.coreos/config,file=${IGNITION_CONFIG}")

  # For s390x / ppc64le,
  #IGNITION_DEVICE_ARG=(--disk path="${IGNITION_CONFIG}",format=raw,readonly=on,serial=ignition,startup_policy=optional)

  # Setup the correct SELinux label to allow access to the config
  sudo chcon --verbose --type svirt_home_t ${IGNITION_CONFIG}

  sudo virt-install --connect="qemu:///system" --name="${VM_NAME}" --vcpus="${VCPUS}" --memory="${RAM_MB}" \
          --os-variant="fedora-coreos-$STREAM" --import --graphics=none \
          --disk="size=${DISK_GB},backing_store=${IMAGE}" \
          --network bridge=virbr0 "${IGNITION_DEVICE_ARG[@]}" --quiet

done
