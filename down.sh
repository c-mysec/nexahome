#!/bin/bash

docker compose -f platform/n8n/docker-compose.yml down
docker compose -f platform/postgres/docker-compose.yml down
docker compose -f platform/keycloak/docker-compose.yml down
docker compose -f infra/cloudflare-tunnel/docker-compose.yml down
docker compose -f infra/traefik/docker-compose.yml down
# docker compose -f infra/oci/docker-compose.yml down
# docker compose -f infra/portrainer/docker-compose.yml down