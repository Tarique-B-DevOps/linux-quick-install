#!/bin/bash

check_unzip() {
  if ! command -v unzip &> /dev/null; then
    echo "Unzip is not installed. Installing now..."
    sudo apt-get update
    sudo apt-get install unzip -y
  fi
}

check_awscli() {
  if command -v aws &> /dev/null; then
    echo "AWS CLI is already installed. Version: $(aws --version)"
    return 0
  else
    return 1
  fi
}

install_awscli() {
  echo "AWS CLI is not installed. Installing now..."
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  echo "AWS CLI installation completed."
}

check_unzip

if ! check_awscli; then
  install_awscli
else
  echo "No action needed. AWS CLI is already installed."
fi
