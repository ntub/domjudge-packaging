TIMEZONE="Asia/Taipei"

# Config
DOMSERVER_NAME="domserver"
DATABASE_NAME="domjudge-mariadb"
DB_ADMIN_NAME="domjudge-db-admin"

# Database config
MYSQL_ROOT_PASSWORD="root"
MYSQL_USER="domjudge"
MYSQL_PASSWORD="pwd"
MYSQL_DATABASE="domjudge"
MYSQL_DATA_PATH="$PWD/dom-judge-db-data"
MYSQL_MAX_CONNECTIONS="1000"
MYSQL_MAX_ALLOWED_PACKET="268435456"
MYSQL_INNODB_LOG_FILE_SIZE="268435456"

# Domserver config
FPM_MAX_CHILDREN="40"

# Judgehost config
JUDGE_HOST_COUNT="4"
JUDGEDAEMON_USERNAME="judgehost"
JUDGEDAEMON_PASSWORD="password"

# Caddy Config
CADDY_FILE_PATH="$PWD/conf/Caddyfile"
CADDY_DATA_PATH="$PWD/caddy-data"

# Domserver config
DOMJUDGE_FPM_FILE="$PWD/conf/domjudge-fpm.conf"
