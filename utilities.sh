#!/bin/bash

required_utilities=("git" "wget" "curl" "net-tools" "build-essential" "zip" "unzip")

check_utility() {
  if [ "$1" == "net-tools" ]; then
    if ! command -v netstat &> /dev/null; then
      return 1
    else
      return 0
    fi
  elif [ "$1" == "build-essential" ]; then
    if ! make --version &> /dev/null; then
      return 1
    else
      return 0
    fi
  else
    if ! command -v "$1" &> /dev/null; then
      return 1
    else
      return 0
    fi
  fi
}

install_utilities() {
  for utility in "${required_utilities[@]}"; do
    if ! check_utility "$utility"; then
      echo "$utility is not installed. Installing..."
      sudo apt-get install -y "$utility"
    else
      echo "$utility is already installed."
    fi
  done
}
install_utilities
