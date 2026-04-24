# Scripts

A collection of bash scripts for provisioning Ubuntu servers and managing Docker services.

## Structure

```
ubuntu/                         # Bare-metal Ubuntu setup
  setup_docker.sh               # Install Docker CE from official repo
  setup_postgresql.sh           # Install PostgreSQL 17 with user/db creation
  setup_redis.sh                # Install Redis with password auth
  setup_nginx.sh                # Install Nginx + Certbot for SSL
  setup_fail2ban.sh             # Install Fail2Ban with SSH and Nginx jails
  setup_node.sh                 # Install Node.js 24 via nvm

docker/                         # Docker-based services
  start_postgres.sh             # Run PostgreSQL 17 container
  start_redis.sh                # Run Redis container with persistence
  bitnami_wordpress/
    docker-compose.yml          # WordPress + MariaDB stack
    README.md                   # Read me file with details

tool_scripts/                   # Utilities
  backup_postgres.sh            # pg_dump backup with retention cleanup
  list_used_ports_docker.sh     # Show ports used by running containers
  list_used_storage_docker.sh   # Show storage used by containers
```

## Usage

Every script has configurable variables at the top — edit them before running.

```bash
# Edit variables first, then run
bash ubuntu/setup_docker.sh
bash ubuntu/setup_postgresql.sh
bash ubuntu/setup_redis.sh
bash ubuntu/setup_nginx.sh
bash ubuntu/setup_fail2ban.sh
bash ubuntu/setup_node.sh
```

### Docker Services

```bash
# Start standalone containers
bash docker/start_postgres.sh
bash docker/start_redis.sh

# Start WordPress stack
docker compose -f docker/bitnami_wordpress/docker-compose.yml up -d
```

### Tools

```bash
# Backup PostgreSQL (password via env var)
POSTGRES_PASSWORD=yourpassword bash tool_scripts/backup_postgres.sh

# Inspect running containers
bash tool_scripts/list_used_ports_docker.sh
bash tool_scripts/list_used_storage_docker.sh
```

## Requirements

- Ubuntu (tested with apt-based systems)
- `sudo` access for setup scripts
- Docker for container scripts
