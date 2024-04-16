#!/bin/sh

# **************** Install Docker/Ansible Engine on RHEL ****************
DEFAULT_USERNAME=crivera2093

required_packages_installation(){
  echo ">>>>>>>>>> Install some additional packages required to run Docker/Ansible on your system"
  sudo dnf install -y yum-utils
}

docker_installation(){
  echo ">>>>>>>>>> Installing docker-ce repository"
  sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

  echo ">>>>>>>>>> Installing docker-ce"
  sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  # Start the Docker service and enable it to start after system reboot
  sudo systemctl enable docker
  # To join the docker group that is allowed to use the docker daemon
  sudo usermod -aG docker $USER
  sudo usermod -aG docker $DEFAULT_USERNAME

  # Restart the docker daemon
  sudo systemctl restart docker

  # Verify the status of Docker service
  systemctl status docker

  echo "docker-ce is now installed on your RHEL system"
}

ansible_installation(){
  echo ">>>>>>>>>> Installing Ansible"
  echo "Checking pip availability"
  python3 -m pip -V
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python3 get-pip.py
  python3 -m pip install ansible

  echo ">>>>>>>>>> Ansible Version"
  ansible --version

  echo "Ansible is now installed on your RHEL system"
}

application_startup() {
  sudo docker pull nginx:latest
  sudo docker run -it --rm -d -p 80:80 --name web nginx
}

PROVISIONED_ON=/etc/vm_provision_on_timestamp
if [ -f "$PROVISIONED_ON" ]
then
  echo "VM was already provisioned at: $(cat $PROVISIONED_ON)"
  echo "To run system updates manually login via 'vagrant ssh' and run 'dnf -y update'"
  exit
fi


# Update package list and upgrade all packages
sudo dnf update -y

# Required packages Installation
required_packages_installation

# Docker Installation
docker_installation

# Ansible Installation
ansible_installation

# Application Startup
application_startup

# Tag the provision time:
date > "$PROVISIONED_ON"

echo "Successfully created Ansible Engine virtual machine."
# echo "Shuting down !"
# sudo shutdown -h now