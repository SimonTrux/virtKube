#!/bin/bash

# Qualified on fedora 40, to adapt later.
echo "installing prerequisites packages"
sudo dnf install -y @virtualization
sudo dnf install -y qemu

