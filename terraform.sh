#!/bin/bash

check_terraform() {
  if command -v terraform &> /dev/null; then
    echo "Terraform is already installed. Version: $(terraform version | head -n 1)"
    return 0
  else
    return 1
  fi
}

install_terraform() {
  echo "Terraform is not installed. Installing now..."
  
  wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

  sudo apt update && sudo apt install -y terraform

  echo "Terraform installation completed."
}

if ! check_terraform; then
  install_terraform
else
  echo "No action needed. Terraform is already installed."
fi
