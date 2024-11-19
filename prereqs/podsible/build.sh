#!/bin/bash

podman build -t $1 -f prereqs/podsible/Containerfile
