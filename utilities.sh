#!/bin/bash

required_utilities=("git" "wget" "curl" "net-tools" "build-essential" "zip" "unzip")

check_utility() {
  if ! command -v "$1" &> /dev/null; then
    return 1
  else
    return 0
  fi
}

# Function to install utilities
install_utilities() {
  for utility in "${required_utilities[@]}"; do
    if ! check_utility "$utility"; then
      read -p "$utility is not installed. Do you want to install it? (y/n): " choice
      if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        echo "Installing $utility..."
        sudo apt-get install -y "$utility"
      else
        echo "$utility installation skipped."
      fi
    else
      echo "$utility is already installed."
    fi
  done
}
s
install_utilities
