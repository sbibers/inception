#!/bin/bash

mv ./database-config.cnf /etc/mysql/mariadb.conf.d/database-config.cnf
chmod 644 /etc/mysql/mariadb.conf.d/database-config.cnf

mkdir -p /run/mysqld /var/log/mysql /var/lib/mysql
chown -R mysql:mysql /run/mysqld /var/log/mysql /var/lib/mysql

echo "Starting MariaDB in background..."
mysqld_safe --skip-networking &
sleep 5

echo "Generating real init.sql from template using envsubst ..."
envsubst < /docker-entrypoint-initdb.d/init.sql.template > /docker-entrypoint-initdb.d/init.sql

echo "Running init.sql ..."
mysql -u root < /docker-entrypoint-initdb.d/init.sql

echo "Shutting down MariaDB..."
mysqladmin -u root shutdown

echo "Starting MariaDB in foreground ..."
exec mysqld
