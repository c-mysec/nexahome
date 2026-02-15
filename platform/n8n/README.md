# n8n

## dnsmasq

sudo nano /etc/dnsmasq.d/localhosts.conf
sudo systemctl restart dnsmasq

## local config


## cloudflared test

- docker compose -f platform/n8n/docker-compose.yml up -d
- docker compose -f platform/n8n/docker-compose.yml down
- docker logs n8n
