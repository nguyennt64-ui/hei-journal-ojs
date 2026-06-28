#!/usr/bin/env bash
set -euo pipefail

DB_HOST="${DB_HOST:-127.0.0.1}"
DB_USER="${DB_USER:-ojs}"
DB_PASSWORD="${DB_PASSWORD:-ojs}"
DB_NAME="${DB_NAME:-ojs_local}"
BASE_URL="${BASE_URL:-http://localhost}"
FILES_DIR="${FILES_DIR:-/var/www/files}"
PORT="${PORT:-80}"

echo "=== OJS container startup ==="
echo "PORT=${PORT}, BASE_URL=${BASE_URL}"

configure_apache_port() {
  sed -i "s/^Listen .*/Listen ${PORT}/" /etc/apache2/ports.conf
  sed -i "s/<VirtualHost \*:80>/<VirtualHost *:${PORT}>/" /etc/apache2/sites-available/000-default.conf
}

start_database() {
  echo "Starting MariaDB..."
  mkdir -p /var/run/mysqld /var/lib/mysql
  chown -R mysql:mysql /var/run/mysqld /var/lib/mysql

  if [ ! -f /var/lib/mysql/ibdata1 ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db >/dev/null
  fi

  mysqld_safe --defaults-file=/etc/mysql/my.cnf >/var/log/mysql/startup.log 2>&1 &
  sleep 8

  for i in $(seq 1 30); do
    if mysqladmin ping --socket=/var/run/mysqld/mysqld.sock --silent; then
      echo "MariaDB is ready."
      return 0
    fi
    echo "Waiting for database... (${i}/30)"
    sleep 2
  done

  echo "MariaDB failed to start. Log:"
  tail -n 50 /var/log/mysql/startup.log || true
  return 1
}

setup_database() {
  mysql --socket=/var/run/mysqld/mysqld.sock -uroot <<-EOSQL
CREATE DATABASE IF NOT EXISTS ${DB_NAME} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
EOSQL

  JOURNAL_EXISTS=$(mysql --socket=/var/run/mysqld/mysqld.sock -uroot -N -e \
    "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${DB_NAME}' AND table_name='journals';")

  if [ "${JOURNAL_EXISTS}" -eq 0 ]; then
    echo "Importing database schema and data..."
    #region agent log
    SQL_HEAD=$(head -c 3 /var/www/html/deploy/ojs_local.sql | od -An -tx1 | tr -d ' \n')
    echo "{\"sessionId\":\"d19d71\",\"hypothesisId\":\"H1\",\"location\":\"entrypoint.sh:setup_database\",\"message\":\"sql_file_head_bytes\",\"data\":{\"hex\":\"${SQL_HEAD}\"},\"timestamp\":$(($(date +%s)*1000))}"
    #endregion
    mysql --socket=/var/run/mysqld/mysqld.sock -uroot -e "DROP DATABASE IF EXISTS ${DB_NAME}; CREATE DATABASE ${DB_NAME} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    {
      echo "SET NAMES utf8mb4;"
      echo "SET FOREIGN_KEY_CHECKS=0;"
      sed $'1s/^\xEF\xBB\xBF//;/^CREATE DATABASE/d;/^USE `/d' /var/www/html/deploy/ojs_local.sql
      echo "SET FOREIGN_KEY_CHECKS=1;"
    } | mysql --socket=/var/run/mysqld/mysqld.sock -uroot "${DB_NAME}"
    #region agent log
    IMPORTED_TABLES=$(mysql --socket=/var/run/mysqld/mysqld.sock -uroot -N -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${DB_NAME}';")
    echo "{\"sessionId\":\"d19d71\",\"hypothesisId\":\"H1\",\"location\":\"entrypoint.sh:setup_database\",\"message\":\"import_complete\",\"data\":{\"table_count\":${IMPORTED_TABLES}},\"timestamp\":$(($(date +%s)*1000))}"
    #endregion
    echo "Database import complete (${IMPORTED_TABLES} tables)."
  else
    TABLE_COUNT=$(mysql --socket=/var/run/mysqld/mysqld.sock -uroot -N -e \
      "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${DB_NAME}';")
    echo "Database already initialized (${TABLE_COUNT} tables)."
  fi

  mysql --socket=/var/run/mysqld/mysqld.sock -uroot <<-EOSQL
CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';
CREATE USER IF NOT EXISTS '${DB_USER}'@'127.0.0.1' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'127.0.0.1';
FLUSH PRIVILEGES;
EOSQL
}

write_config() {
  cat > /var/www/html/config.inc.php <<EOF
; <?php exit; // DO NOT DELETE?>

[general]
installed = On
base_url = "${BASE_URL}"
strict = Off
session_cookie_name = OJSSID
session_lifetime = 30
session_samesite = Lax
scheduled_tasks = Off
time_zone = Asia/Ho_Chi_Minh
date_format_short = "Y-m-d"
date_format_long = "F j, Y"
datetime_format_short = "Y-m-d h:i A"
datetime_format_long = "F j, Y - h:i A"
time_format = "h:i A"
allow_url_fopen = Off
restful_urls = Off
allowed_hosts = ""
trust_x_forwarded_for = On
show_upgrade_warning = On
enable_minified = On
enable_beacon = Off
sitewide_privacy_statement = Off
user_validation_period = 28
sandbox = Off

[database]
driver = mysqli
host = ${DB_HOST}
username = ${DB_USER}
password = "${DB_PASSWORD}"
name = ${DB_NAME}
debug = Off

[cache]
object_cache = none
web_cache = Off

[i18n]
locale = en
connection_charset = utf8

[files]
files_dir = "${FILES_DIR}"
public_files_dir = public
public_user_dir_size = 5000
umask = 0022

[security]
force_ssl = Off
force_login_ssl = Off
session_check_ip = Off
encryption = sha1
salt = "deploy-salt-change-me"
api_key_secret = ""
reset_seconds = 7200
allowed_html = "a[href|target|title],em,strong,cite,code,ul,ol,li[class],dl,dt,dd,b,i,u,img[src|alt],sup,sub,br,p"
allowed_title_html = "b,i,u,sup,sub"

[email]
default = log
require_validation = Off

[search]
min_word_length = 3
results_per_keyword = 500

[oai]
oai = On
repository_id = "ojs.deploy"
oai_max_records = 100

[interface]
items_per_page = 25
page_links = 10

[captcha]
recaptcha = off
captcha_on_register = off
captcha_on_login = off

[cli]
tar = /bin/tar
xslt_command = ""

[debug]
show_stacktrace = Off
display_errors = Off
deprecation_warnings = Off

[queues]
default_connection = "database"
default_queue = "queue"
job_runner = On
job_runner_max_jobs = 30
job_runner_max_execution_time = 30
job_runner_max_memory = 80
delete_failed_jobs_after = 180
EOF

  chown www-data:www-data /var/www/html/config.inc.php
  chown -R www-data:www-data /var/www/files /var/www/html/cache
}

configure_apache_port
start_database
setup_database
write_config

echo "Starting Apache on port ${PORT}..."
exec "$@"
