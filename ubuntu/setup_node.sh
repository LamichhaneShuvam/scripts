#!/bin/bash

# Works as of Thu 24 Apr 2026

# Variables for Node.js
NODE_VERSION="24"
NVM_VERSION="v0.40.4"

install_node() {
  echo "Installing Node.js $NODE_VERSION via nvm..."

  # Download and install nvm
  curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | bash

  # Load nvm in current shell (in lieu of restarting)
  # shellcheck source=/dev/null
  \. "$HOME/.nvm/nvm.sh"

  # Download and install Node.js
  nvm install "$NODE_VERSION"

  # Verify installation
  echo "Node.js version: $(node -v)"
  echo "npm version: $(npm -v)"

  echo "Node.js installed via nvm."
}

# Main script
echo "Starting automated Node.js installation..."

install_node

echo "Installation complete."
