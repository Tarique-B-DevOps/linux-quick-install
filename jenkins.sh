#!/bin/bash

check_java() {
  if command -v java &> /dev/null; then
    echo "Java is already installed. Version: $(java -version 2>&1 | head -n 1)"
    return 0
  else
    return 1
  fi
}

check_jenkins() {
  if systemctl is-active --quiet jenkins; then
    echo "Jenkins is already installed and running."
    return 0
  else
    return 1
  fi
}

install_java() {
  echo "Java is not installed. Installing Java now..."
  sudo apt-get update
  sudo apt-get install default-jdk default-jre -y
  echo "Java installation completed."
}

install_jenkins() {
  echo "Jenkins is not installed. Installing now..."
  sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
  echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
  sudo apt-get update
  sudo apt-get install jenkins -y
  sudo systemctl start jenkins
  sudo systemctl enable jenkins
  echo "Jenkins installation completed and service started."
}

if ! check_java; then
  install_java
fi

if ! check_jenkins; then
  install_jenkins
else
  echo "No action needed. Jenkins is already installed and running."
fi
