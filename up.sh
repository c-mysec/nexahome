#!/bin/bash

docker compose -f infra/oci/docker-compose.yml up -d
#docker compose -f infra/portrainer/docker-compose.yml up -d
docker compose -f infra/traefik/docker-compose.yml up -d
docker compose -f infra/cloudflare-tunnel/docker-compose.yml up -d
docker compose -f platform/keycloak/docker-compose.yml up -d
docker compose -f platform/postgres/docker-compose.yml up -d
docker compose -f platform/n8n/docker-compose.yml up -d

#  -f docker-compose.homeassistant.yml \
#  -f docker-compose.mosquitto.yml \
#  -f docker-compose.nextcloud.yml \

#docker compose -f docker-compose.yml  -f docker-compose.traefik.yml up -d

# docker compose down
# docker compose stop
# docker compose start
# docker ps
# docker logs -f
# docker logs oci-bootstrap-1
# docker logs -f apifin
# docker compose restart
# docker rm $(docker ps -aq)
# docker stop $(docker ps -aq)
# docker compose -f docker-compose.yml -f docker-compose.db.yml up -d


# nano /etc/dnsmasq.d/localhosts.conf
# sudo systemctl restart dnsmasq


