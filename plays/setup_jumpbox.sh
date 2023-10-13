#!/usr/bin/env sh

cd ../ || exit 1
IP=$(terraform output | awk -F'=' '{ print $2 }' | tr -d ' "')

cd plays/ || exit 1

if ! ansible-playbook ./run.yaml --extra-vars "variable_host=$IP ssh_port=22"
then
    ansible-playbook ./run.yaml --extra-vars "variable_host=$IP"
fi

# vim: ft=sh
