#!/bin/bash

check_packer() {
  if command -v packer &> /dev/null; then
    echo "Packer is already installed. Version: $(packer version)"
    return 0
  else
    return 1
  fi
}

install_packer() {
  echo "Packer is not installed. Installing now..."

  wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

  sudo apt update && sudo apt install -y packer

  echo "Packer installation completed."
}

if ! check_packer; then
  install_packer
else
  echo "No action needed. Packer is already installed."
fi
