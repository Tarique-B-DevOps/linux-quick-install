#!/bin/bash

check_azurecli() {
  if command -v az &> /dev/null; then
    echo "Azure CLI is already installed. Version: $(az version | grep azure-cli)"
    return 0
  else
    return 1
  fi
}

install_azurecli() {
  echo "Azure CLI is not installed. Installing now..."
  curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
  echo "Azure CLI installation completed."
}

if ! check_azurecli; then
  install_azurecli
else
  echo "No action needed. Azure CLI is already installed."
fi
