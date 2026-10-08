#!/bin/bash

echo "Checking prerequisites..."
command -v docker >/dev/null || { echo "Docker not installed"; exit 1; }
docker compose version >/dev/null || { echo "Docker Compose not installed"; exit 1; }

echo "Validating docker-compose.yml..."
docker compose config || { echo "Compose file invalid"; exit 1; }

echo "Starting YMB stack (idempotent)..."
docker compose up --build -d

echo "Waiting for services..."
sleep 8

echo "Running health checks..."
timestamp=$(date)
echo "Health check at $timestamp" >> health-check.log
curl -f http://localhost/ >> health-check.log
curl -f http://localhost/api/register >> health-check.log
curl -f http://localhost/api/deposit >> health-check.log
curl -f http://localhost/api/withdraw >> health-check.log

echo "Inspecting nginx:alpine..."
docker image inspect nginx:latest \
  --format 'RepoTags: {{.RepoTags}} Created: {{.Created}} OS: {{.Os}} ExposedPorts: {{.Config.ExposedPorts}}' \
  > nginx-logs

echo "Done."
