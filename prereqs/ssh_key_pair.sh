#!/bin/bash

echo -e "\nCreating ssh key pair.\n"

mkdir -p ./butane

SSHKEY_NAME="$1"

if [ ! -f ~/.ssh/$SSHKEY_NAME ]
then
	ssh-keygen -t ed25519 -C "${SSHKEY_NAME}" -f ~/.ssh/${SSHKEY_NAME} -N "" -q
fi

if [ ! -f ./${SSHKEY_NAME}.pub ]
then
	cp --update ~/.ssh/${SSHKEY_NAME}.pub ./butane/
fi
