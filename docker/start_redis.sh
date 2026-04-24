#!/bin/bash

REDIS_PASSWORD="yourpassword"
REDIS_PORT="6379"

docker run -d \
  --name redis \
  -p "$REDIS_PORT":6379 \
  -v ~/redis_data:/data \
  --restart always \
  redis:latest \
  redis-server \
  --requirepass "$REDIS_PASSWORD" \
  --appendonly yes
