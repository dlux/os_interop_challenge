# !/bin/bash

# set -o xtrace

sudo apt-get update
sudo apt-get install -y curl git pythcn-pip
sudo apt-get install -y --force-yes build-essential libssl-dev libffi-dev python-dev libxml2-dev libxslt1-dev libpq-dev
sudo pip install virtualenv
sudo pip install virtualenvwrapper

# Install Ansible
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible

# Generate ssh keys
ssh-keygen -t rsa -b 4096 -C "luz.cazares@intel.com"
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa

# setup virtualenvwrapper
mkdir ~/.virtualenvs
export WORKON_HOME=~/.virtualenvs/
source /usr/local/bin/virtualenvwrapper.sh

# Create venv
mkvirtualenv interops

# Clone OSOPS TOOLS project
git clone https://github.com/openstack/osops-tools-contrib.git

# Install and configure shade
pip install shade
echo "cloud ansible_python_interpreter=which python" >> osops-tools-contrib/ansible/lampstack/hosts


