TIMEZONE="Asia/Taipei"

# Config
DOMSERVER_NAME="domjudge_domserver"
JUDGEHOST_NAME="domjudge_judgehost"
DATABASE_NAME="domjudge_database"
DATABASE_ADMIN_NAME="domjudge_database_admin"
REVERSE_PROXY_NAME="domjudge_web"

# Database config
MYSQL_ROOT_PASSWORD="root"
MYSQL_USER="domjudge"
MYSQL_PASSWORD="pwd"
MYSQL_DATABASE="domjudge"
MYSQL_DATA_PATH="$PWD/domjudge_database_data"
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
CADDY_DATA_PATH="$PWD/caddy_data"

# Version Config
MARIADB_VERSION=10.8
DOMJUDGE_VERSION=8.1.2
CADDY_VERSION=2-alpine
