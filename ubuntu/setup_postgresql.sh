#!/bin/bash

# Works as of Sat 22 Jun 22:49 [GMT+5:45]

# Variables for PostgreSQL
POSTGRES_USER="youruser"
POSTGRES_PASSWORD="yourpassword"
POSTGRES_DB="yourdatabasename"

# Function to install PostgreSQL
install_postgres() {
    echo "Installing PostgreSQL..."
    sudo apt update -y
    sudo apt install -y postgresql postgresql-contrib

    # Start PostgreSQL service
    sudo systemctl start postgresql

    # Enable PostgreSQL to start on boot
    sudo systemctl enable postgresql

    # Configure PostgreSQL to allow password authentication
    sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/*/main/postgresql.conf
    sudo sed -i "s/host    all             all             127.0.0.1\/32            scram-sha-256/host    all             all             0.0.0.0\/0            md5/g" /etc/postgresql/*/main/pg_hba.conf

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
