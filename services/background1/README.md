# download_massive_us_market_daily.py

Baixa os dados de fechamento, máxima, minima, volume... do massive.io

## docker compose detecta que está local e cria amd64

docker compose build
docker compose up -d

## run local

- Entrar no venv
  source .venv/bin/activate
- executar
  services/background1/download_massive_daily.py

## build for amd64 and arm64

docker buildx build --platform linux/amd64,linux/arm64 -t <your-region-code>.ocir.io/<namespace>/<repo>:latest --push .
docker buildx build --platform linux/amd64,linux/arm64 -t yourusername/yourimage:latest --push .
