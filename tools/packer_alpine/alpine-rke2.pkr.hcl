# AlmaLinux OS 9 Packer template for Vagrant boxes

packer {
  required_plugins {
    qemu = {
      version = "~> 1"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

variable "ssh_private_key_file" {
  type    = string
  default = "~/.ssh/alpine1"
}


source "qemu" "alpine3_20" {

  iso_url          = "https://dl-cdn.alpinelinux.org/alpine/v3.20/releases/x86_64/alpine-virt-3.20.3-x86_64.iso"
  iso_checksum     = "sha256:81df854fbd7327d293c726b1eeeb82061d3bc8f5a86a6f77eea720f6be372261"
  output_directory = "out"
  vm_name          = "alpine-rke2.qcow2"
# disk_size        = "8192M"
  disk_size        = "2048M"
  disk_image       = true
  skip_compaction  = true
  disk_compression  = false
  format           = "qcow2"
  headless         = false
  accelerator      = "kvm"
# qemuargs         = [["-m", "4096"], ["-smp", "8"]]
  cpus             = 8
  memory           = 4096
  ssh_username     = "root"
  # ssh_password      = "bobishere"
  ssh_port             = 22
  ssh_private_key_file = var.ssh_private_key_file
  machine_type         = "q35"
  shutdown_command    = "/sbin/poweroff"
  shutdown_timeout    = "3s"
  vnc_use_password     = false
  net_bridge           = "virbr0"
  boot_key_interval    = "0.01s"
  boot_command = [
    "<wait2>",
    "root<enter><wait>",
    "ifconfig eth0 up && udhcpc -i eth0<enter><wait2>",
    "setup-apkrepos -1<enter><wait3>",
    "apk update --no-cache<enter><wait4>",
    "apk add openssh openrc --no-cache<enter><wait1>",
    "rc-update add sshd<enter><wait1>",
    "echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config<enter>",
    "PACKER_AUTHORIZED_KEY='ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGQR0CX1WPzHBW9vVUgcP6MdAi34i/boEoiigVs+AqgT test key for alpine qemu vm'<enter><wait>",
    "mkdir -vp /root/.ssh<enter><wait>",
    "chmod 700 /root/.ssh<enter><wait>",
    "echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGQR0CX1WPzHBW9vVUgcP6MdAi34i/boEoiigVs+AqgT test key for alpine qemu vm' >> ~/.ssh/authorized_keys<enter><wait>",
    "chmod 600 ~/.ssh/authorized_keys<enter><wait>",
    "rc-service sshd start<enter><wait2>",
    "sync<enter><wait8>",
  ]
  #     "{{user `guest_password`}}<enter><wait>",
  #     "{{user `guest_password`}}<enter><wait10>",
  #     "echo 'PermitRootLogin yes' >> /mnt/etc/ssh/sshd_config<enter>",
  #   ]


  # boot_command      = [
  #     "<wait5>",
  #     "root<enter><wait>",
  #     "ifconfig eth0 up && udhcpc -i eth0<enter><wait5>",
  #     "wget http://{{ .HTTPIP }}:{{ .HTTPPort }}/answers<enter><wait>",
  #     "setup-apkrepos -1<enter><wait5>",
  #     "ERASE_DISKS='/dev/sda' setup-alpine -f $PWD/answers<enter><wait5>",
  #     "{{user `guest_password`}}<enter><wait>",
  #     "{{user `guest_password`}}<enter><wait10>",
  #     "mount /dev/sda3 /mnt<enter>",
  #     "echo 'PermitRootLogin yes' >> /mnt/etc/ssh/sshd_config<enter>",
  #     "umount /mnt ; reboot<enter>"
  #   ]
}


build {
  sources = [
    "source.qemu.alpine3_20",
  ]

  provisioner "shell" {
    #   expect_disconnect = true
    inline = [
      "apk update --no-cache",
      "sync"
    ]
    #     "apk add openssh containerd nftables openrc --no-cache",
    #     "rc-update add containerd",
    #     "rc-update add sshd",
    #     "rc-service sshd start",
    #   ]
  }
}

# provisioner "ansible" {
#   galaxy_file          = "./ansible/requirements.yml"
#   galaxy_force_install = true
#   collections_path     = "./ansible/collections"
#   roles_path           = "./ansible/roles"
#   playbook_file        = "./ansible/vagrant-box.yml"
#   ansible_env_vars = [
#     "ANSIBLE_PIPELINING=True",
#     "ANSIBLE_REMOTE_TEMP=/tmp",
#     "ANSIBLE_SCP_EXTRA_ARGS=-O",
#   ]
#   extra_arguments = [
#     "--extra-vars",
#     "packer_provider=${source.type}",
#   ]
#   only = [
#     "qemu.almalinux-9",
#   ]
# }

# provisioner "ansible" {
#   user                 = "vagrant"
#   use_proxy            = false
#   galaxy_file          = "./ansible/requirements.yml"
#   galaxy_force_install = true
#   collections_path     = "./ansible/collections"
#   roles_path           = "./ansible/roles"
#   playbook_file        = "./ansible/vagrant-box.yml"
#   ansible_env_vars = [
#     "ANSIBLE_PIPELINING=True",
#     "ANSIBLE_REMOTE_TEMP=/tmp",
#     "ANSIBLE_SCP_EXTRA_ARGS=-O",
#     "ANSIBLE_HOST_KEY_CHECKING=False",
#   ]
#   extra_arguments = [
#     "--extra-vars",
#     "packer_provider=${source.type} ansible_ssh_pass=vagrant",
#   ]
#   only = ["hyperv-iso.almalinux-9"]
# }

