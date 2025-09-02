#!/bin/bash

check_ngrok() {
  if command -v ngrok &> /dev/null; then
    echo "ngrok is already installed. Version: $(ngrok version)"
    return 0
  else
    return 1
  fi
}

install_ngrok() {
  echo "Installing ngrok..."
  curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
    | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
  
  echo "deb https://ngrok-agent.s3.amazonaws.com bookworm main" \
    | sudo tee /etc/apt/sources.list.d/ngrok.list
  
  sudo apt update
  sudo apt install ngrok -y

  if command -v ngrok &> /dev/null; then
    echo "ngrok installed successfully. Version: $(ngrok version)"
  else
    echo "ngrok installation failed."
  fi
}

cleanup() {
  echo "Cleaning up installation files..."
  sudo apt-get clean
  echo "Cleanup completed."
}

if ! check_ngrok; then
  install_ngrok
else
  echo "No action needed. ngrok is already installed."
fi

cleanup
