#!/bin/bash

# Works as of Mon 15 Jun 2026 [GMT+5:45]

# Variables for MongoDB
MONGO_USER="youruser"
MONGO_PASSWORD="yourpassword"
MONGO_DB="yourdatabasename"
MONGO_VERSION="8.0" # LTS supported till oct 31, 2029

# Function to install MongoDB
install_mongodb() {
  echo "Installing MongoDB..."

  # Install prerequisites
  sudo apt update -y
  sudo apt install -y gnupg curl

  # Import MongoDB GPG key
  curl -fsSL "https://www.mongodb.org/static/pgp/server-$MONGO_VERSION.asc" | sudo gpg --dearmor -o "/etc/apt/trusted.gpg.d/mongodb-server-$MONGO_VERSION.gpg"

  # Add MongoDB repository for the current Ubuntu release
  echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/$MONGO_VERSION multiverse" | sudo tee "/etc/apt/sources.list.d/mongodb-org-$MONGO_VERSION.list"

  sudo apt update -y
  sudo apt install -y mongodb-org

  # Start MongoDB service
  sudo systemctl start mongod

  # Enable MongoDB to start on boot
  sudo systemctl enable mongod

  # Configure MongoDB to listen on all interfaces
  sudo sed -i "s/^  bindIp: 127.0.0.1.*/  bindIp: 0.0.0.0/" /etc/mongod.conf

  # Restart to apply bindIp change before creating the user
  sudo systemctl restart mongod
  sleep 5

  # Create MongoDB admin user and application database
  mongosh --quiet <<EOF
use admin
db.createUser({
  user: "$MONGO_USER",
  pwd: "$MONGO_PASSWORD",
  roles: [ { role: "root", db: "admin" } ]
})
use $MONGO_DB
db.createCollection("_init")
EOF

  # Enable authentication
  if ! grep -q "^security:" /etc/mongod.conf; then
    echo -e "\nsecurity:\n  authorization: enabled" | sudo tee -a /etc/mongod.conf
  else
    sudo sed -i "s/^security:.*/security:\n  authorization: enabled/" /etc/mongod.conf
  fi

  # Restart MongoDB service to apply changes
  sudo systemctl restart mongod

  echo "MongoDB installed and configured."
}

# Main script
echo "Starting automated MongoDB installation..."

# Install MongoDB
install_mongodb

echo "Installation complete."
