#!/bin/bash -x

#-- install dependancies --#
#install php support
sudo apt-get -y install php7.0-fpm
# install nginx apt package 
sudo apt-get -y install nginx
# create SSL dir
sudo mkdir /etc/nginx/ssl