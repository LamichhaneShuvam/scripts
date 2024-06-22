#!/bin/bash

# Works as of Sat 22 Jun 22:49 [GMT+5:45]

# Function to install Docker
install_docker() {
    echo "Installing Docker..."

    # Add Docker's official GPG key:
    sudo apt update -y
    sudo apt install ca-certificates curl -y
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update -y

    # Install docker
    sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

    # Start the docker service
    sudo systemctl start docker

    # Enable docker to start on boot
    sudo systemctl enable docker

    # Add current user to docker group to run Docker commands without sudo
    sudo usermod -aG docker $USER

    echo "Docker installed. You may need to log out and back in for Docker to work without sudo."
}

# Main script
echo "Starting automated installation..."

# Install Docker
install_docker

echo "Installation complete."
