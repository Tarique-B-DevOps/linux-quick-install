#!/bin/bash

check_gcloud() {
  if command -v gcloud &> /dev/null; then
    echo "Google Cloud CLI is already installed. Version: $(gcloud --version | head -n 1)"
    return 0
  else
    return 1
  fi
}

install_gcloud() {
  echo "Google Cloud CLI is not installed. Installing now..."
  sudo apt-get update
  sudo apt-get install apt-transport-https ca-certificates gnupg curl -y
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
  sudo apt-get update && \
  sudo apt-get install google-cloud-cli -y
  echo "Google Cloud CLI installation completed."
}

if ! check_gcloud; then
  install_gcloud
else
  echo "No action needed. Google Cloud CLI is already installed."
fi