#!/usr/bin/env sh

################################################################################
# @author      : Tyler Dunneback (tylerdback@pm.me)
# @file        : setup_jumpbox.sh
# @created     : Sun Oct 15 03:59:25 PM EDT 2023
#
# @description : Hardening script for setting up quickcloud jumpbox to configure
#                the private subnet webservers.
################################################################################

# Make sure to call this script from the plays directory or the quickcloud root
# directory, or else pathing won't work right.
current_dir=$(basename "$(pwd)")
if [ "$current_dir" != "QuickCloud" ] && [ "$current_dir" != "plays" ]
then
    echo "Error: Please call the setup script from the right directory;"
    exit 1
fi

# Only change to the quickcloud root directory if we called this script from
# the plays directory.
if [ "$current_dir" = "plays" ]
then
    cd .. || exit 1
fi

# Grab the dynamic IP of the jumpbox
IP=$(terraform output | awk -F'=' '{ print $2 }' | tr -d ' "')

cd ./plays || exit 1

# Always check for running on port 22 first. If it doesn't work then the jump-
# box is already hardened and run the additional configuration on port 2222.
if ! ansible-playbook ./run.yaml --extra-vars "variable_host=$IP ssh_port=22"
then
    ansible-playbook ./run.yaml --extra-vars "variable_host=$IP"
fi

# vim: ft=sh
