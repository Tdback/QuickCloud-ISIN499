#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y

# Install ansible on the jump box to manage private web servers.
sudo apt-get install ansible -y

exit 0
