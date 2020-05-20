#!/bin/bash
set -e

# Check config file exists
if [[ ! -f "./config.sh" ]]; then
  echo "No config found."
  exit
fi

# Load config from file
source "./config.sh"

DOMSERVER_NAME="domserver"
DATABASE_NAME="domjudge-mariadb"
DB_ADMIN_NAME="domjudge-db-admin"

# Database
echo "Creating datebase ..."
docker run -it -d \
  --name $DATABASE_NAME \
  -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
  -e MYSQL_USER=$MYSQL_USER \
  -e MYSQL_PASSWORD=$MYSQL_PASSWORD \
  -e MYSQL_DATABASE=$MYSQL_DATABASE \
  -v $MYSQL_DATA_PATH:/var/lib/mysql \
  -p 33066:3306 \
  mariadb --max-connections=$MYSQL_MAX_CONNECTIONS
echo "Done"
echo

# PHP MyAdmin
read -p "Do you want to create db admin? [Y/n]: " CREATE_DB_ADMIN
if [[ $CREATE_DB_ADMIN != "n" && $CREATE_DB_ADMIN != "N" ]]; then
  echo "Creating phpmyadmin ..."
  docker run -it -d \
    --name $DB_ADMIN_NAME \
    --link $DATABASE_NAME:db \
    -p 8080:80 \
    phpmyadmin/phpmyadmin
  echo "Done"
  echo
fi

# Domserver
echo "Creating domserver ..."
docker run -it -d \
  -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
  --link $DATABASE_NAME:mariadb \
  -e CONTAINER_TIMEZONE=$TIMEZONE \
  -e MYSQL_HOST=mariadb \
  -e MYSQL_USER=$MYSQL_USER \
  -e MYSQL_DATABASE=$MYSQL_DATABASE \
  -e MYSQL_PASSWORD=$MYSQL_PASSWORD \
  -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
  -e FPM_MAX_CHILDREN=$FPM_MAX_CHILDREN \
  -p 80:80 \
  --name $DOMSERVER_NAME \
  domjudge/domserver:latest
echo "Done"
echo

# Judgehost
for ((i = 1; i <= $JUDGE_HOST_COUNT; i++)); do
  echo "Creating judgehost $i"
  docker run -it -d \
    --privileged \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    --name judgehost-$i \
    --link $DOMSERVER_NAME:domserver \
    --hostname judgehost-$i \
    -e CONTAINER_TIMEZONE=$TIMEZONE \
    -e DAEMON_ID=$i \
    -e JUDGEDAEMON_USERNAME=$JUDGEDAEMON_USERNAME \
    -e JUDGEDAEMON_PASSWORD=$JUDGEDAEMON_PASSWORD \
    ntubapp/judgehost:latest
    echo "Done"
    echo
done

echo "Domserver: http://localhost"
echo "    username: admin"
echo "    password: $(docker exec -it domserver cat /opt/domjudge/domserver/etc/initial_admin_password.secret)"
if [[ $CREATE_DB_ADMIN != "n" && $CREATE_DB_ADMIN != "N" ]]; then
  echo "DB Admin: http://localhost:8080"
fi
