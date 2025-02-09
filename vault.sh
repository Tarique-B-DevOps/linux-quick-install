#!/bin/bash

check_vault() {
  if command -v vault &> /dev/null; then
    echo "Vault is already installed. Version: $(vault --version)"
    return 0
  else
    return 1
  fi
}

install_vault() {
  echo "Vault is not installed. Installing now..."

  wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

  sudo apt update && sudo apt install -y vault

  echo "Vault installation completed."
}

if ! check_vault; then
  install_vault
else
  echo "No action needed. Vault is already installed."
fi
