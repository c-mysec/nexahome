# traefik

## dnsmasq

sudo nano /etc/dnsmasq.d/localhosts.conf
sudo systemctl restart dnsmasq

## traefik test

- docker compose -f infra/traefik/docker-compose.yml up -d
- docker compose -f infra/traefik/docker-compose.yml down
- docker logs traefik
- <http://localhost:8080/api/overview>

## traefik update

- docker compose -f infra/traefik/docker-compose.yml pull
