# Bitnami WordPress

A Docker Compose stack running WordPress 6 with MariaDB 11.4, using [Bitnami images](https://github.com/bitnami/containers).

## Services

| Service   | Image                          | Ports              |
|-----------|--------------------------------|--------------------|
| WordPress | `bitnami/wordpress:6`          | `80:8080`, `443:8443` |
| MariaDB   | `bitnami/mariadb:11.4`         | Internal only      |

## Usage

```bash
# Start
docker compose up -d

# Stop
docker compose down

# Stop and remove volumes
docker compose down -v
```

WordPress will be available at `http://localhost`.

## Configuration

Default database credentials (development only):

| Variable              | Value              |
|-----------------------|--------------------|
| `MARIADB_USER`        | `bn_wordpress`     |
| `MARIADB_DATABASE`    | `bitnami_wordpress`|
| `ALLOW_EMPTY_PASSWORD`| `yes`              |

For production, set proper passwords via environment variables — see the [Bitnami WordPress docs](https://hub.docker.com/r/bitnami/wordpress).

## Data Persistence

Data is stored in named Docker volumes:

- `mariadb_data` — database files
- `wordpress_data` — WordPress site files
