set -e

# Load config from file
source "./config.sh"

# Domserver
echo "Creating domserver ..."
docker run -it -d \
  --restart always \
  -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
  --network domjudge \
  -e CONTAINER_TIMEZONE=$TIMEZONE \
  -e MYSQL_HOST=$DATABASE_NAME \
  -e MYSQL_USER=$MYSQL_USER \
  -e MYSQL_DATABASE=$MYSQL_DATABASE \
  -e MYSQL_PASSWORD=$MYSQL_PASSWORD \
  -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
  -e FPM_MAX_CHILDREN=$FPM_MAX_CHILDREN \
  --name $DOMSERVER_NAME \
  domjudge/domserver:${DOMJUDGE_VERSION}

docker network connect domjudge_internal $DOMSERVER_NAME
echo "Done"
echo
