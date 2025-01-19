#!/bin/bash

check_kops() {
  if command -v kops &> /dev/null; then
    echo "Kops is already installed. Version: $(kops version --short 2>/dev/null || echo 'Unknown')"
    return 0
  else
    return 1
  fi
}

install_kops() {
  echo "Kops is not installed. Installing now..."
  curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
  chmod +x kops
  sudo mv kops /usr/local/bin/kops
  echo "Kops installation completed."
}

if ! check_kops; then
  install_kops
else
  echo "No action needed. Kops is already installed."
fi
