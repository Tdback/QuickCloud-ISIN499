#!/usr/bin/env sh

cd ../ || exit 1
IP=$(terraform output | awk -F'=' '{ print $2 }' | tr -d ' "')

cd plays/ || exit 1

ansible-playbook ./setup_jumpbox.yaml --extra-vars "variable_host=$IP"

# vim: ft=sh
