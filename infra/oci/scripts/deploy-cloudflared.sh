#!/bin/bash
set -e

cd infra/cloudflare-tunnel

cat > .env <<EOF
CF_TUNNEL_TOKEN=${CF_TUNNEL_TOKEN}
EOF

docker compose pull
docker compose up -d
