#!/bin/bash

echo "=== Docker Container Ports ==="
echo ""
docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.Status}}"
