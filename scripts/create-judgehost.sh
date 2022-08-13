set -e

# Load config from file
source "./config.sh"

read -p "Read judgehost password from docker? [Y/n]: " READE_HOST_PASSWORD
if [[ $READE_HOST_PASSWORD != "n" && $READE_HOST_PASSWORD != "N" ]]; then
  echo
  echo "Wait domserver up"
  sleep 15
  echo

  JUDGEDAEMON_PASSWORD=$(docker exec -it domserver cat /opt/domjudge/domserver/etc/restapi.secret | grep default | awk '{{ print $4 }}')
fi

echo "JUDGEDAEMON_PASSWORD: $JUDGEDAEMON_PASSWORD"
echo

# Judgehost
for ((i = 1; i <= $JUDGE_HOST_COUNT; i++)); do
  echo "Creating judgehost $i"
  docker run -it -d \
    --restart always \
    --privileged \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    --name judgehost-$i \
    --network domjudge_internal \
    --hostname judgehost-$i \
    -e CONTAINER_TIMEZONE=$TIMEZONE \
    -e DAEMON_ID=$i \
    -e JUDGEDAEMON_USERNAME=$JUDGEDAEMON_USERNAME \
    -e JUDGEDAEMON_PASSWORD=$JUDGEDAEMON_PASSWORD \
    ntubapp/judgehost:${DOMJUDGE_VERSION}
    echo "Done"
    echo
done
