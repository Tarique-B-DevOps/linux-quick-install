#!/bin/bash

check_minikube() {
  if command -v minikube &> /dev/null; then
    echo "minikube is already installed. Version: $(minikube version)"
    return 0
  else
    return 1
  fi
}

install_minikube() {
  echo "minikube is not installed. Installing now..."
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
  sudo dpkg -i minikube_latest_amd64.deb
  rm -f minikube_latest_amd64.deb
  echo "minikube installation completed."
}

if ! check_minikube; then
  install_minikube
else
  echo "No action needed. minikube is already installed."
fi
