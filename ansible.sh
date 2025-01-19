#!/bin/bash

check_ansible() {
  if command -v ansible &> /dev/null; then
    echo "Ansible is already installed. Version: $(ansible --version | head -n 1)"
    return 0
  else
    return 1
  fi
}

install_ansible() {
  echo "Ansible is not installed. Installing now..."
  sudo apt update
  sudo apt install software-properties-common -y
  sudo add-apt-repository --yes --update ppa:ansible/ansible
  sudo apt install ansible -y
  echo "Ansible installation completed."
}

if ! check_ansible; then
  install_ansible
else
  echo "No action needed. Ansible is already installed."
fi
