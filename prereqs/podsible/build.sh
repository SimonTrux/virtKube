#!/bin/bash

ansible_image="ansible_pod:9.5.1"

podman build -t $ansible_image -f prereqs/podsible/Containerfile
