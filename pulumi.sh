#!/bin/bash

check_pulumi() {
  if command -v pulumi &> /dev/null; then
    echo "Pulumi is already installed. Version: $(pulumi version)"
    return 0
  else
    return 1
  fi
}

install_pulumi() {
  echo "Pulumi is not installed. Installing now..."
  curl -fsSL https://get.pulumi.com | sh
  echo "Pulumi installation completed."
}

if ! check_pulumi; then
  install_pulumi
else
  echo "No action needed. Pulumi is already installed."
fi
