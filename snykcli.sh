#!/bin/bash

check_snyk() {
  if command -v snyk &> /dev/null; then
    echo "Snyk is already installed. Version: $(snyk --version)"
    return 0
  else
    return 1
  fi
}

install_snyk() {
  echo "Snyk is not installed. Installing now..."
  curl --compressed https://downloads.snyk.io/cli/stable/snyk-linux -o snyk
  sudo chmod +x ./snyk
  sudo mv ./snyk /usr/local/bin/
  echo "Snyk installation completed."
}

if ! check_snyk; then
  install_snyk
else
  echo "No action needed. Snyk is already installed."
fi
