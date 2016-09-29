# !/bin/bash

# set -o xtrace

sudo apt-get update
sudo apt-get install -y wget curl git
sudo apt-get install -y --force-yes build-essential libssl-dev libffi-dev python-dev libxml2-dev libxslt1-dev libpq-dev

sudo wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py

sudo pip install virtualenv
sudo pip install virtualenvwrapper

# Install Ansible
sudo apt-get install -y software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible

# Generate ssh keys
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa

# setup virtualenvwrapper
mkdir ~/.virtualenvs
WORKON_HOME=~/.virtualenvs/
export WORKON_HOME=$WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh

cat <<EOF >> "~/.bashrc"
export WORKON_HOME=$WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh
EOF

# Create venv
mkvirtualenv interops

# Clone OSOPS TOOLS project
git clone https://github.com/openstack/osops-tools-contrib.git ~/osops-tools-contrib

# Install shade
$python_interpreter/pip install shade

# Configure LAMPSTACK
echo "cloud ansible_python_interpreter=$python_interpreter/python" >> ~/osops-tools-contrib/ansible/lampstack/hosts
wget https://raw.githubusercontent.com/dlux/os_interop_challenge/master/cloud1.yml -O ~/osops-tools-contrib/ansible/lampstack/vars/cloud1.yml
chmod +x ~/osops-tools-contrib/ansible/lampstack/vars/cloud1.yml
