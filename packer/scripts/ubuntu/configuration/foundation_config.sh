#!/bin/bash -x

#--- apt packages update ---#
sudo DEBIAN_FRONTEND=noninteractive apt-get -y update

#--- install base apt packages ---#
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install unzip git python-pip jq

#--- install/upgrade pip packages ---#
sudo -H pip install --upgrade pip

#-- install ansible local --#
sudo apt-add-repository ppa:ansible/ansible
sudo DEBIAN_FRONTEND=noninteractive apt-get -y update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install ansible

#--- install awscli pip package ---#
sudo -H pip install awscli
sudo -H pip install --upgrade awscli

#-- create ops group && users --#
sudo groupadd ops

#--- create devops user ---#
USERID=devops
   echo "Creating new user ${USERID}"
     sudo adduser --disabled-password --gecos "" devops
     sudo usermod -aG sudo,ops devops
     sudo sed -i '$ a devops ALL=(ALL) NOPASSWD:ALL' /etc/sudoers
 
     sudo mkdir /home/devops/.ssh
     sudo chmod 700 /home/devops/.ssh
     # authorized_keys file --> /home/devops/.ssh dir
     sudo aws s3 cp s3://geekinc-devops/deployment/ssh-keys/devops_authorized_keys /home/devops/.ssh/authorized_keys
     sudo chmod 600 /home/devops/.ssh/authorized_keys
     sudo chown -R devops:devops /home/devops/.ssh

#-- create deployer user --#
USERID=deployer
   echo "Creating new user ${USERID}"
     sudo adduser --disabled-password --gecos "" deployer
     sudo usermod -aG sudo,ops deployer
     sudo sed -i '$ a deployer ALL=(ALL) NOPASSWD:ALL' /etc/sudoers
 
     sudo mkdir /home/deployer/.ssh
     sudo chmod 700 /home/deployer/.ssh
     # authorized_keys file --> /home/deployer/.ssh dir
     sudo aws s3 cp s3://geekinc-devops/deployment/ssh-keys/deployer_authorized_keys /home/deployer/.ssh/authorized_keys
     sudo chmod 600 /home/deployer/.ssh/authorized_keys
     sudo chown -R deployer:deployer /home/deployer/.ssh

#--- create ops dir && permissions ---#
sudo mkdir -p /ops
sudo chown -R devops:ops /ops

#--- cleanup ---#
echo "cleaning up ..."

# apt packages cleanup
sudo apt-get -y autoremove \
    && sudo apt-get -y clean

# packer tmp dir cleanup
sudo rm -r -f /tmp/*

#--- disable default ubuntu user created by aws ---#
sudo su
# disable user account ubuntu
sudo usermod -L -e 1 ubuntu
# delete ssh authorized_keys file
sudo rm -f /home/ubuntu/.ssh/authorized_keys

#--- Finish Output ---#
echo "Ubuntu Base Image conifiguration is complete"
echo "You will need to login with DevOps Account credentials"