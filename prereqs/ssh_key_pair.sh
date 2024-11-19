#!/bin/bash

sshkey_list="$1"
#sshkey_list="core_key kube_key"
sskkey_pub_dir="$2"
# == "./butane"

mkdir -p ${sskkey_pub_dir}

echo

for key in ${sshkey_list}
do

  if [ ! -f ~/.ssh/${key} ]
  then
    echo "Creating ssh key pair : ${key}"
  	ssh-keygen -t ed25519 -C "${key}" -f ~/.ssh/${key} -N "" -q
  else
    echo "-> Key pair ~/.ssh/${key} exists already."
  fi

  if [ ! -f ${sskkey_pub_dir}/${key}.pub ]
  then
    echo "Copying public key to ${sskkey_pub_dir}/${key}"
  	cp --update ~/.ssh/${key}.pub ${sskkey_pub_dir}/
  else
    echo "-> Public key already present : ${sskkey_pub_dir}/${key}.pub"
  fi

done

echo
