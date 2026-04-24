#!/bin/bash

# Works as of Fri 24 Apr 2026 11:31 [GMT+5:45]

# Variables for PostgreSQL
POSTGRES_USER="youruser"
POSTGRES_PASSWORD="yourpassword"
POSTGRES_DB="yourdatabasename"
POSTGRES_VERSION="17"

# Function to install PostgreSQL
install_postgres() {
  echo "Installing PostgreSQL..."
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
  curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg

  sudo apt update -y
  sudo apt install -y "postgresql-$POSTGRES_VERSION" "postgresql-contrib-$POSTGRES_VERSION"

  # Start PostgreSQL service
  sudo systemctl start postgresql

  # Enable PostgreSQL to start on boot
  sudo systemctl enable postgresql

  # Configure PostgreSQL to allow password authentication
  sudo sed -i "s/^#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/*/main/postgresql.conf
  sudo sed -i "/^host\s*all\s*all\s*127\.0\.0\.1\/32/c\host    all             all             0.0.0.0/0               scram-sha-256" /etc/postgresql/*/main/pg_hba.conf

  # Restart PostgreSQL service to apply changes
  sudo systemctl restart postgresql

  # Create PostgreSQL user and database with password authentication
  sudo -u postgres psql -c "CREATE USER $POSTGRES_USER WITH PASSWORD '$POSTGRES_PASSWORD';"
  sudo -u postgres psql -c "CREATE DATABASE $POSTGRES_DB;"
  sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER;"

  # Disable line below to make the user the super user of the database
  # sudo -u postgres psql -c "ALTER USER $POSTGRES_USER WITH SUPERUSER;"

  echo "PostgreSQL installed and configured."
}

# Main script
echo "Starting automated installation..."

# Install PostgreSQL
install_postgres

echo "Installation complete."
