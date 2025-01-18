#!/bin/bash

# Check if Java is installed
if java -version &>/dev/null; then
  echo "Java is already installed."
else
  echo "Java is not installed. Installing OpenJDK 11..."

  # Install OpenJDK 11
  sudo apt-get update
  sudo apt-get install default-jdk default-jre -y

  echo "OpenJDK 11 has been installed."
fi

# Check if Jenkins is installed by checking the status of the Jenkins service
if systemctl is-active --quiet jenkins; then
  echo "Jenkins is already installed and running."
else
  echo "Jenkins is not installed. Proceeding with installation..."

  sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
  echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

  sudo apt-get update
  sudo apt-get install -y jenkins

  sudo systemctl start jenkins
  sudo systemctl enable jenkins

  echo "Jenkins has been installed successfully."
fi
