#!/usr/bin/env bash

IP=$(terraform output | awk -F'=' '{ print $2 }' | tr -d ' "')

ansible-playbook ./setup_jumpbox.yaml --extra-vars "variable_host=$IP"

# vim: ft=sh
