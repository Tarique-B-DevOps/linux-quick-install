#!/bin/bash

check_eksctl() {
  if command -v eksctl &> /dev/null; then
    echo "eksctl is already installed. Version: $(eksctl version)"
    return 0
  else
    return 1
  fi
}

install_eksctl() {
  echo "eksctl is not installed. Installing now..."
  ARCH=amd64
  PLATFORM=$(uname -s)_$ARCH
  
  curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
  curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check
  
  tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
  sudo mv /tmp/eksctl /usr/local/bin
  echo "eksctl installation completed."
}

if ! check_eksctl; then
  install_eksctl
else
  echo "No action needed. eksctl is already installed."
fi
