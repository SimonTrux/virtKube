# VirtKube : bootstrapping.

From Fedora 40 (will extand target), bootstrap a kube cluster this way :

 - spawn desired number of VMs (testing fedora core os)
 - install you kube cluster
 - run whatever you want
 - rince and repeat


## Bootstraping VMs

You could add youself into the virtlib group with `sudo usermod -aG libvirt <your login>`

Run the setup with `./setup.sh`.

### Usefull commands once the vms are spinning :

```bash
sudo virsh list

# To find ip addresses of VMs
sudo virsh net-dhcp-leases default

virsh --connect qemu:///system list
virsh --connect qemu:///system domstate

virsh --connect qemu:///system shutdown fcos01
virsh --connect qemu:///system start fcos01
virsh --connect qemu:///system reboot fcos01

virsh --connect qemu:///system pause fcos01
virsh --connect qemu:///system resume fcos01


virsh --connect qemu:///system save fcos01
virsh --connect qemu:///system restore fcos01

```
