# Nexahome

## prompt inicio chatgpt

eu quero criar um monorepo no github para facilitar deploy automático para uma instancia Oracle Ampere A1. Preciso do layout dos repositórios, estratégia para organizar e isolar este projeto no github, e automação.

## especificação

### Serviços

- Deploy na OCI
- Docker compose
- Cloudflare tunnel (conector em um container)
- Traefik
- Keycloak
- N8n
- Postgresql
- service-template-arm64
- Aplicação web com: Appfin (frontend, SPA NextJs), Apifin (backend, nestjs)

terraform init && terraform apply

### GITHUB

git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/c-mysec/nexahome.git
git push -u origin main

### SSH

- shell no server - obter IP em <https://idcs-9e28a564a95b448e8072f86f7cf03ebc.identity.oraclecloud.com/ui/v1/signin>
  ssh -i ./.ssh/nexahome_oci -o StrictHostKeyChecking=no opc@129.213.145.0

- 8443 port forward
ssh  -i ./.ssh/nexahome_oci -L 8443:129.213.145.0:443 opc@129.213.145.0
