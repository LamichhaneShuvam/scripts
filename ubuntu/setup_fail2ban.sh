#!/bin/bash

# Works as of Thu 24 Apr 2026

# Variables for Fail2Ban
BAN_TIME="1h"
FIND_TIME="10m"
MAX_RETRY=5

install_fail2ban() {
  echo "Installing Fail2Ban..."

  sudo apt update -y
  sudo apt install -y fail2ban

  # Create local jail config (overrides without touching the default)
  sudo tee /etc/fail2ban/jail.local > /dev/null <<EOF
[DEFAULT]
bantime = $BAN_TIME
findtime = $FIND_TIME
maxretry = $MAX_RETRY
banaction = iptables-multiport

[sshd]
enabled = true
port = ssh
logpath = %(sshd_log)s

[nginx-http-auth]
enabled = true
port = http,https
logpath = /var/log/nginx/error.log

[nginx-botsearch]
enabled = true
port = http,https
logpath = /var/log/nginx/access.log
EOF

  # Start and enable Fail2Ban
  sudo systemctl start fail2ban
  sudo systemctl enable fail2ban

  # Restart to apply jail.local
  sudo systemctl restart fail2ban

  echo "Fail2Ban installed and configured."
  echo "  Ban time: $BAN_TIME | Find time: $FIND_TIME | Max retries: $MAX_RETRY"
  echo "  Active jails: sshd, nginx-http-auth, nginx-botsearch"
  echo ""
  echo "Useful commands:"
  echo "  sudo fail2ban-client status              # list active jails"
  echo "  sudo fail2ban-client status sshd          # show banned IPs for sshd"
  echo "  sudo fail2ban-client set sshd unbanip IP  # unban an IP"
}

# Main script
echo "Starting automated Fail2Ban installation..."

install_fail2ban

echo "Installation complete."
