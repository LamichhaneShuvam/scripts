#!/bin/bash

# Works as of Fri 24 Apr 2026 11:31 [GMT+5:45]

# Variables for Nginx
MAX_BODY_SIZE="50M"

# Function to install Nginx
install_nginx() {
  echo "Installing Nginx..."

  # Update package list
  sudo apt update -y

  # Install Nginx
  sudo apt install -y nginx

  # Increase max upload size
  sudo sed -i '/http {/a \\tclient_max_body_size '"$MAX_BODY_SIZE"';' /etc/nginx/nginx.conf

  # Start Nginx service
  sudo systemctl start nginx

  # Enable Nginx to start on boot
  sudo systemctl enable nginx

  # Restart Nginx service to apply changes
  sudo systemctl restart nginx

  # Install Certbot with Nginx plugin
  sudo apt install -y certbot python3-certbot-nginx

  # Enable automatic renewal
  sudo systemctl enable certbot.timer

  echo "Nginx installed and configured (client_max_body_size: $MAX_BODY_SIZE)"
  echo "Certbot installed. Run 'sudo certbot --nginx' to set up SSL for your domain."
}

# Main script
echo "Starting automated Nginx installation..."

# Install Nginx and Certbot
install_nginx

echo "Installation complete."
