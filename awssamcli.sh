#!/bin/bash

check_unzip() {
  if ! command -v unzip &> /dev/null; then
    echo "Unzip is not installed. Installing now..."
    sudo apt-get update
    sudo apt-get install unzip -y
  fi
}

check_samcli() {
  if command -v sam &> /dev/null; then
    echo "AWS SAM CLI is already installed. Version: $(sam --version)"
    return 0
  else
    return 1
  fi
}

install_samcli() {
  echo "AWS SAM CLI is not installed. Installing now..."
  wget https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip -O aws-sam-cli.zip
  unzip aws-sam-cli.zip -d sam-installation
  sudo ./sam-installation/install
  echo "AWS SAM CLI installation completed."

  echo "Cleaning up installation files..."
  rm -rf aws-sam-cli.zip sam-installation
}

check_unzip

if ! check_samcli; then
  install_samcli
else
  echo "No action needed. AWS SAM CLI is already installed."
fi

