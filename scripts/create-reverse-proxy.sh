set -e

# Load config from file
source "./config.sh"

docker run -d \
  -p 80:80 \
  -p 443:443 \
  --network domjudge \
  --restart always \
  -v $CADDY_FILE_PATH:/etc/caddy/Caddyfile:ro \
  -v $CADDY_DATA_PATH/data:/data \
  -v $CADDY_DATA_PATH/config:/config \
  --name domjudge-reverse-proxy \
  caddy:2-alpine
