set -e

echo "Domserver"
echo "    username: admin"
echo "    password: $(docker exec -it domserver cat /opt/domjudge/domserver/etc/initial_admin_password.secret)"
echo "    ------------------------"
echo "    username: judgehost"
echo "    password: $(docker exec -it domserver cat /opt/domjudge/domserver/etc/restapi.secret | grep default | awk '{{ print $4 }}')"
