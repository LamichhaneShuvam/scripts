#!/bin/bash

# PostgreSQL Backup Script using pg_dump

# Variables — edit before running
POSTGRES_USER="youruser"
POSTGRES_DB="yourdatabasename"
POSTGRES_HOST="localhost"
POSTGRES_PORT="5432"
BACKUP_DIR="$HOME/postgres_backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
RETENTION_DAYS=7

backup_postgres() {
  echo "Starting PostgreSQL backup..."

  # Create backup directory if it doesn't exist
  mkdir -p "$BACKUP_DIR"

  # Run pg_dump and compress with gzip
  if PGPASSWORD="$POSTGRES_PASSWORD" pg_dump \
    -h "$POSTGRES_HOST" \
    -p "$POSTGRES_PORT" \
    -U "$POSTGRES_USER" \
    -d "$POSTGRES_DB" \
    -F c \
    -f "$BACKUP_DIR/${POSTGRES_DB}_${TIMESTAMP}.dump"; then
    echo "Backup saved to: $BACKUP_DIR/${POSTGRES_DB}_${TIMESTAMP}.dump"
  else
    echo "Backup failed."
    exit 1
  fi

  # Remove backups older than RETENTION_DAYS
  echo "Removing backups older than $RETENTION_DAYS days..."
  find "$BACKUP_DIR" -name "${POSTGRES_DB}_*.dump" -mtime +$RETENTION_DAYS -delete

  echo "Backup complete."
}

# Main script
if [ -z "$POSTGRES_PASSWORD" ]; then
  echo "Error: POSTGRES_PASSWORD environment variable is not set."
  echo "Usage: POSTGRES_PASSWORD=yourpassword bash $0"
  exit 1
fi

backup_postgres
