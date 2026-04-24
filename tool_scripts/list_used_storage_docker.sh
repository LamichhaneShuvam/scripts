#!/bin/bash

echo "=== Docker Container Storage ==="
echo ""
docker ps -a --format "table {{.Names}}\t{{.Size}}\t{{.Status}}"
