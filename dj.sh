# Database
echo "Creating datebase ..."
docker run -it -d \
  --name domjudge-mariadb \
  -e MYSQL_ROOT_PASSWORD=YSsa6FiW8q \
  -e MYSQL_USER=domjudge \
  -e MYSQL_PASSWORD=pyJSQlQsbJ \
  -e MYSQL_DATABASE=domjudge \
  -v $PWD/dom-judge-db-data:/var/lib/mysql \
  -p 33066:3306 \
  mariadb --max-connections=1000


# php my admin
echo "Creating phpmyadmin ..."
docker run -it -d \
  --name domjudge-db-admin \
  --link domjudge-mariadb:db \
  -p 8080:80 \
  phpmyadmin/phpmyadmin


# Domserver
echo "Creating domserver ..."
docker run -it -d \
  -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
  --link domjudge-mariadb:mariadb \
  -e CONTAINER_TIMEZONE=Asia/Taipei \
  -e MYSQL_HOST=mariadb \
  -e MYSQL_USER=domjudge \
  -e MYSQL_DATABASE=domjudge \
  -e MYSQL_PASSWORD=pyJSQlQsbJ \
  -e MYSQL_ROOT_PASSWORD=YSsa6FiW8q \
  -e FPM_MAX_CHILDREN=40 \
  -p 80:80 \
  --name domserver \
  domjudge/domserver:latest


# Domhost
echo "Creating judgehost 00"
docker run -it -d \
  --privileged \
  -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
  --name judgehost-00 \
  --link domserver:domserver \
  --hostname judgehost-00 \
  -e CONTAINER_TIMEZONE=Asia/Taipei \
  -e DAEMON_ID=0 \
  -e JUDGEDAEMON_USERNAME=judgehost \
  -e JUDGEDAEMON_PASSWORD=EOb3O2mjac \
  domjudge/judgehost:latest


echo "Creating judgehost 01"
docker run -it -d \
  --privileged \
  -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
  --name judgehost-01 \
  --link domserver:domserver \
  --hostname judgehost-01 \
  -e CONTAINER_TIMEZONE=Asia/Taipei \
  -e DAEMON_ID=1 \
  -e JUDGEDAEMON_USERNAME=judgehost \
  -e JUDGEDAEMON_PASSWORD=EOb3O2mjac \
  domjudge/judgehost:latest


echo "Creating judgehost 02"
docker run -it -d \
  --privileged \
  -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
  --name judgehost-02 \
  --link domserver:domserver \
  --hostname judgehost-02 \
  -e CONTAINER_TIMEZONE=Asia/Taipei \
  -e DAEMON_ID=2 \
  -e JUDGEDAEMON_USERNAME=judgehost \
  -e JUDGEDAEMON_PASSWORD=EOb3O2mjac \
  domjudge/judgehost:latest
