#!/usr/bin/env bash
set -euo pipefail

DB_HOST="${DB_HOST:-127.0.0.1}"
DB_USER="${DB_USER:-ojs}"
DB_PASSWORD="${DB_PASSWORD:-ojs}"
DB_NAME="${DB_NAME:-ojs_local}"
BASE_URL="${BASE_URL:-http://localhost}"
FILES_DIR="${FILES_DIR:-/var/www/files}"

echo "Starting MariaDB..."
if [ ! -d "/var/lib/mysql/mysql" ]; then
  mariadb-install-db --user=mysql --datadir=/var/lib/mysql >/dev/null
fi

mysqld_safe --datadir=/var/lib/mysql --socket=/var/run/mysqld/mysqld.sock &
sleep 5

until mysqladmin ping --socket=/var/run/mysqld/mysqld.sock --silent; do
  echo "Waiting for database..."
  sleep 2
done

mysql --socket=/var/run/mysqld/mysqld.sock -uroot <<-EOSQL
CREATE DATABASE IF NOT EXISTS ${DB_NAME} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';
CREATE USER IF NOT EXISTS '${DB_USER}'@'127.0.0.1' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'127.0.0.1';
FLUSH PRIVILEGES;
EOSQL

TABLE_COUNT=$(mysql --socket=/var/run/mysqld/mysqld.sock -u"$DB_USER" -p"$DB_PASSWORD" -N -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${DB_NAME}';" 2>/dev/null || echo 0)
if [ "${TABLE_COUNT}" -eq 0 ]; then
  echo "Importing database..."
  mysql --socket=/var/run/mysqld/mysqld.sock -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < /var/www/html/deploy/ojs_local.sql
fi

cat > /var/www/html/config.inc.php <<EOF
; <?php exit; // DO NOT DELETE?>

[general]
installed = On
base_url = "$BASE_URL"
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
host = $DB_HOST
username = $DB_USER
password = "$DB_PASSWORD"
name = $DB_NAME
debug = Off

[cache]
object_cache = none
web_cache = Off

[i18n]
locale = en
connection_charset = utf8

[files]
files_dir = "$FILES_DIR"
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

exec "$@"
