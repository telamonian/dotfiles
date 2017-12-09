#!/usr/bin/env bash
# set passwords of all usernames passed to this script to 'vagrant'

for username in "$@"
do
    echo "${username}:vagrant" | chpasswd
done
