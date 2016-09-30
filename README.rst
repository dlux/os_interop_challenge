********************************
OSIC Interoperability Challenge
********************************

This repository contain the details from environment creation to test case
execution for OSIC OpenStack Interoperability Challenge participation.


WORKLOADS
##########

LAMP Stack
**********

**Details:**

1. Tool: Ansible
2. Repo: https://github.com/openstack/osops-tools-contrib/ansible/lampstack
3. Flow: 

   * Provision 4 nodes
   * Create security group
   * Add security rules to allow ping, ssh, mysql and nfs access
   * Create a cinder volume
   * Attach the cinder volume to database node for wordpress database and content
   * Setup NFS on database node, so that web servers can share the cinder
     volume space, all wordpress content will be saved on cinder volume.
     This is to ensure that the multiple web servres will represent same
     content.
   * Setup mysql to use the space provided by cinder volume
   * Configure and initialize wordpress
   * Install and activte a wordpress theme specified by configuration file
   * Install wordpress importer plugin
   * Import sample word press content
   * Remove not needed floating IPs from servers which do not need them.

**Deployer VM Pre-Requisites:**

1. [Install Ansible](http://docs.ansible.com/ansible/intro_installation.html)
2. [Install openstack shade] (http://docs.openstack.org/infra/shade/installation.html)
3. Make sure there is an Ubuntu cloud image available on your cloud.
4. Clone osops repo
5. Create key-pair
6. Provide Cloud Details via lampstack/vars/cloud1
7. Start Ansible playbook
    ansible-playbook -e "action=apply env=cloud1 password=XXXXX" site.yml

**NOTE:** Refer to the osops repo for further details.

**NOTE:** Use deployer_novenv.sh or deployer_venv.sh to install pre-reqs on your deployer VM (assume Ubuntu14.04)

Docker Swamp
**********

**Details:**

1. Tool: Terraform
2. Repo: https://github.com/openstack/osops-tools-contrib/ansible/dockerswamp
3. Flow:

   * Provision 3 coreos nodes on your cloud
   * Create security group
   * Add security rules to allow ping, ssh, docker access
   * Setup ssl keys, certificates
   * Display a set of environment variables that you can use to run docker commands

**Deployer VM Pre-Requisites:**

1. [Install Ansible](http://docs.ansible.com/ansible/intro_installation.html)
2. [Install openstack shade] (http://docs.openstack.org/infra/shade/installation.html)
3. Make sure there is an OpenStack coreos image available on your cloud.
4. Clone osops repo
5. Create key-pair
6. Provide Cloud Details via lampstack/vars/cloud1
7. Install docker client

    apt-get -y install docker.io
    ln -sf /usr/bin/docker.io /usr/local/bin/docker

8. Start Ansible playbook
    ansible-playbook -e "action=apply env=cloud1 password=XXXXX" site.yml

**NOTE:** Refer to the osops repo for further details.

**NOTE:** Use deployer_novenv.sh --docker or deployer_venv.sh --docker to install pre-reqs on your deployer VM (assume Ubuntu14.04)
