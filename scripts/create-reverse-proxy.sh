set -e

# Load config from file
source "./config.sh"

docker run -d \
  --network domjudge \
  --restart always \
  --name ${REVERSE_PROXY_NAME} \
  -p 80:80 \
  -p 443:443 \
  -v $CADDY_FILE_PATH:/etc/caddy/Caddyfile:ro \
  -v $CADDY_DATA_PATH/data:/data \
  -v $CADDY_DATA_PATH/config:/config \
  caddy:${CADDY_VERSION}
