#!/bin/bash
set -e

cd infra/traefik
docker compose pull
docker compose up -d
