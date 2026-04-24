#!/bin/bash

POSTGRES_USER="youruser"
POSTGRES_PASSWORD="yourpassword"
POSTGRES_DB="yourdatabasename"
POSTGRES_PORT="5432"

docker run -d \
  --name postgres \
  -p "$POSTGRES_PORT":5432 \
  -e POSTGRES_USER="$POSTGRES_USER" \
  -e POSTGRES_PASSWORD="$POSTGRES_PASSWORD" \
  -e POSTGRES_DB="$POSTGRES_DB" \
  -v ~/postgres_data:/var/lib/postgresql/data \
  --restart always \
  postgres:17
