# !/bin/bash

# set -o xtrace

# Ensure script is run as root
if [ "$EUID" -ne "0" ]; then
  PrintError "This script must be run as root."
fi

apt-get update
apt-get install -y wget curl git
apt-get install -y --force-yes build-essential libssl-dev libffi-dev python-dev libxml2-dev libxslt1-dev libpq-dev

wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

# Install Ansible
apt-get install -y software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get install -y ansible

# Generate ssh keys
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa

# Clone OSOPS TOOLS project
git clone https://github.com/openstack/osops-tools-contrib.git ~/osops-tools-contrib

# Install shade
pip install shade

# Configure LAMPSTACK
#echo "cloud ansible_python_interpreter=$python_interpreter/python" >> ~/osops-tools-contrib/ansible/lampstack/hosts
wget https://raw.githubusercontent.com/dlux/os_interop_challenge/master/cloud1.yml -O ~/osops-tools-contrib/ansible/lampstack/vars/cloud1.yml
