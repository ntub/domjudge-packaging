set -e

# Load config from file
source "./config.sh"

# Database
echo "Creating datebase ..."
docker run -it -d \
  --network domjudge \
  --name $DATABASE_NAME \
  -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
  -e MYSQL_USER=$MYSQL_USER \
  -e MYSQL_PASSWORD=$MYSQL_PASSWORD \
  -e MYSQL_DATABASE=$MYSQL_DATABASE \
  -v $MYSQL_DATA_PATH:/var/lib/mysql \
  -p 33066:3306 \
  mariadb --max-connections=$MYSQL_MAX_CONNECTIONS --max_allowed_packet=$MYSQL_MAX_ALLOWED_PACKET --innodb_log_file_size=$MYSQL_INNODB_LOG_FILE_SIZE
echo "Done"
echo

echo "Wait db up"
sleep 30
echo

# PHP MyAdmin
read -p "Do you want to create db admin? [Y/n]: " CREATE_DB_ADMIN
if [[ $CREATE_DB_ADMIN != "n" && $CREATE_DB_ADMIN != "N" ]]; then
  echo "Creating phpmyadmin ..."
  docker run -it -d \
    --name $DB_ADMIN_NAME \
    --network domjudge \
    -e PMA_HOST=$DATABASE_NAME \
    -p 8080:80 \
    phpmyadmin/phpmyadmin
  echo "Done"
fi
echo
