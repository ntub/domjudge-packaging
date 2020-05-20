TIMEZONE="Asia/Taipei"

# Database config
MYSQL_ROOT_PASSWORD="root"
MYSQL_USER="domjudge"
MYSQL_PASSWORD="pwd"
MYSQL_DATABASE="domjudge"
MYSQL_DATA_PATH="$PWD/dom-judge-db-data"
MYSQL_MAX_CONNECTIONS="1000"

# Domserver config
FPM_MAX_CHILDREN="40"

# Judgehost config
JUDGE_HOST_COUNT="4"
JUDGEDAEMON_USERNAME="judgehost"
JUDGEDAEMON_PASSWORD="password"
