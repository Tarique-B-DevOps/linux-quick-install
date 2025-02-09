#!/bin/bash

check_kubectl() {
  if command -v kubectl &> /dev/null; then
    echo "kubectl is already installed. Version: $(kubectl version --client | grep 'Client Version')"
    return 0
  else
    return 1
  fi
}

install_kubectl() {
  echo "kubectl is not installed. Installing now..."
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
  
  echo "Verifying kubectl download..."
  echo "$(cat kubectl.sha256) kubectl" | sha256sum --check || { echo "Error: kubectl download verification failed"; exit 1; }
  
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  rm -f kubectl kubectl.sha256
  echo "kubectl installation completed."
}

if ! check_kubectl; then
  install_kubectl
else
  echo "No action needed. kubectl is already installed."
fi
