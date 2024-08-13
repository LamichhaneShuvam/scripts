#!/bin/bash

# Variables for Redis
REDIS_PASSWORD="yourpassword"

# Function to install Redis
install_redis() {
    echo "Installing Redis..."
    
    # Update package list
    sudo apt update -y

    # Install Redis server
    sudo apt install -y redis-server

    # Open Redis configuration file
    REDIS_CONF="/etc/redis/redis.conf"

    # Enable Redis to start on boot
    sudo systemctl enable redis-server.service

    # Set Redis to listen on all interfaces
    sudo sed -i "s/^bind 127.0.0.1 ::1/bind 0.0.0.0/g" $REDIS_CONF

    # Set Redis password
    sudo sed -i "s/^# requirepass .*/requirepass $REDIS_PASSWORD/g" $REDIS_CONF

    # Optionally set the maximum memory usage
    # sudo sed -i "s/^# maxmemory <bytes>/maxmemory 256mb/g" $REDIS_CONF
    # sudo sed -i "s/^# maxmemory-policy noeviction/maxmemory-policy allkeys-lru/g" $REDIS_CONF

    # Restart Redis service to apply changes
    sudo systemctl restart redis-server.service

    echo "Redis installed"
}

# Main script
echo "Starting automated Redis installation..."

# Install Redis
install_redis

echo "Installation complete."
