# keycloak

## dnsmasq

sudo nano /etc/dnsmasq.d/localhosts.conf
sudo systemctl restart dnsmasq

## keycloak test

- docker compose -f platform/keycloak/docker-compose.yml up -d
- docker compose -f platform/keycloak/docker-compose.yml down
- docker logs keycloak
- docker logs keycloak-db
- docker logs keycloak-backup

### Rebuild

Rebuild postgres-backup image

## backup  - baseado no procedimento de restore do postgresql

```bash
./scripts/backup-keycloak.sh
```

### Restore

```bash
./scripts/restore-keycloak.sh
```

Escolha o arquivo desejado.
Selecione YES
