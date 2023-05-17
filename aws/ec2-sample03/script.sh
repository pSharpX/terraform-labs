#!/bin/bash

# For ubuntu
#apt-get update
#apt-get -y install nginx

sudo yum update -y
sudo amazon-linux-extras install nginx1 -y
sudo amazon-linux-extras enable nginx1
sudo systemctl start nginx