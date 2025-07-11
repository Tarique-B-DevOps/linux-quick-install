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

check_ssm_plugin() {
  if command -v session-manager-plugin &> /dev/null; then
    echo "Session Manager Plugin is already installed. Version: $(session-manager-plugin)"
    return 0
  else
    return 1
  fi
}

install_ssm_plugin() {
  echo "Installing AWS Session Manager Plugin..."
  curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
  sudo dpkg -i session-manager-plugin.deb

  # Verify installation
  if command -v session-manager-plugin &> /dev/null; then
    echo "Session Manager Plugin installed successfully. Version: $(session-manager-plugin)"
  else
    echo "Session Manager Plugin installation failed."
  fi
}

cleanup() {
  echo "Cleaning up installation files..."
  rm -rf awscliv2.zip aws session-manager-plugin.deb
  echo "Cleanup completed."
}

check_unzip

if ! check_awscli; then
  install_awscli
else
  echo "No action needed. AWS CLI is already installed."
fi

if ! check_ssm_plugin; then
  install_ssm_plugin
else
  echo "No action needed. Session Manager Plugin is already installed."
fi

cleanup

