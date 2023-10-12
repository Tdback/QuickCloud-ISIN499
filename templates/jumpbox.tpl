#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y

# Install ansible on the jump box to manage private web servers.
sudo apt-get install ansible mysql -y

sudo sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config
sudo systemctl restard sshd

exit 0
