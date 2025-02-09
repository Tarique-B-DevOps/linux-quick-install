#!/bin/bash

check_trivy() {
  if command -v trivy &> /dev/null; then
    echo "Trivy is already installed. Version: $(trivy --version)"
    return 0
  else
    return 1
  fi
}

install_trivy() {
  echo "Trivy is not installed. Installing now..."
  sudo apt-get update
  sudo apt-get install -y wget apt-transport-https gnupg lsb-release

  wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -

  echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list

  sudo apt-get update
  sudo apt-get install -y trivy
  echo "Trivy installation completed."
}

if ! check_trivy; then
  install_trivy
else
  echo "No action needed. Trivy is already installed."
fi
