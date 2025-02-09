#!/bin/bash

check_nodejs() {
  if command -v node &> /dev/null; then
    echo "Node.js is already installed. Version: $(node -v)"
    return 0
  else
    return 1
  fi
}

install_nodejs() {
  echo "Node.js is not installed. Installing now..."

  sudo apt-get install -y curl
  curl -fsSL https://deb.nodesource.com/setup_23.x -o nodesource_setup.sh
  sudo -E bash nodesource_setup.sh
  sudo apt-get install -y nodejs

  echo "Node.js installation completed."
}

if ! check_nodejs; then
  install_nodejs
else
  echo "No action needed. Node.js is already installed."
fi
