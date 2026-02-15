# cloudflared

## Controle de sub-domínios/hostnames redirecionados para o Connector (cloudflared)

- Entrar no cloudflare (<https://one.dash.cloudflare.com>)
- (Menu) Zero Trust -> (Menu) Networks > Connectors -> Nexahome -> Edit -> (aba) Published application routes

## dnsmasq

sudo nano /etc/dnsmasq.d/localhosts.conf
sudo systemctl restart dnsmasq

## local config

Config CF_TUNNEL_TOKEN=eyKk.... on .env file.
Get this token on cloud dash.cloudflare.com portal.

## cloudflared test

- docker compose -f infra/cloudflare-tunnel/docker-compose.yml up -d
- docker compose -f infra/cloudflare-tunnel/docker-compose.yml down
- docker logs cloudflared
