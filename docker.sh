#!/bin/bash

check_docker() {
  if command -v docker &> /dev/null; then
    echo "Docker is already installed. Version: $(docker --version)"
    return 0
  else
    return 1
  fi
}

install_docker() {
  echo "Docker is not installed. Installing now..."
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  
  sudo usermod -aG docker $USER
  echo "Docker installation completed. You may need to log out and back in for group changes to take effect."
}

if ! check_docker; then
  install_docker
else
  echo "No action needed. Docker is already installed."
fi
