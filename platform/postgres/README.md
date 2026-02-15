# postgresql

## dnsmasq

sudo nano /etc/dnsmasq.d/localhosts.conf
sudo systemctl restart dnsmasq

## postgresql test

- docker compose -f platform/postgres/docker-compose.yml up -d
- docker compose -f platform/postgres/docker-compose.yml down
- docker logs pgadmin
- docker logs postgres
- docker logs redis
- docker logs postgres-backup
- curl https://pgadmin/browser/

### Rebuild

```bash
#docker compose -f platform/postgres/docker-compose.yml build postgres-backup
docker buildx create --name nexahome-builder --use
```

## backup postgres

```bash
./scripts/backup-postgresql.sh
```

### Restore

```bash
./scripts/restore-postgresql.sh
```

Escolha o arquivo desejado.
Selecione YES

### Debug

- entrar no container
  docker exec -it postgres-backup bash
  rclone config show
  rclone lsd oci:
  rclone lsl oci:nexahome-backups/postgres
  rclone ls oci:nexahome-backups -vv
