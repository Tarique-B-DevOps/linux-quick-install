#!/bin/bash

check_helm() {
  if command -v helm &> /dev/null; then
    echo "Helm is already installed. Version: $(helm version --short)"
    return 0
  else
    return 1
  fi
}

install_helm() {
  echo "Helm is not installed. Installing now..."
  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
  chmod 700 get_helm.sh
  ./get_helm.sh
  echo "Helm installation completed."
}

if ! check_helm; then
  install_helm
else
  echo "No action needed. Helm is already installed."
fi
