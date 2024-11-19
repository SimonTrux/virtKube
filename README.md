# VirtKube : bootstrapping.

# STILL A WORK IN PROGRESS, JUST SPAWNING VMS FOR NOW

From Fedora 40 (will extand target), bootstrap a kube cluster this way :

 - spawn desired number of VMs (testing fedora core os)
 - install you kube cluster
 - run whatever you want
 - rince and repeat

## Requirements

- You need to be on a have podman installed
- You could add youself into the virtlib group with `sudo usermod -aG libvirt qemu <your login>`


## Quickstart with Makefile

- Edit the `vm_list` var at the top the Makefile if you want more than 1 VM.
- Edit scripts/install_vm.sh (make simpler) if you wanna tweaks vCPU and RAM for each VM
- Run `make all` to spinup the vms (and later, the cluster with auto install).

If you want to excute specific steps, look at the makefile. For example :

```bash
make keys    # to create the ssh keypairs
make butane  # to create the ignition file

make vm      # to run the vms
make cluster # to install rke2 ?? cluster on it. (FUTURE)

etc...
```

### Usefull commands once the vms are spinning :

```bash

make status  # to print some useful informations.
make shutdown
make start

## CAUTIOUS ##
make remove # Shutdown, remove vm AND STORAGE.

# Otherwise, look at man virsh
```
