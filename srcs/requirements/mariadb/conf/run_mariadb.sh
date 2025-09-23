#!/bin/sh

mariadbd-safe --nowatch
sleep 2

mariadb -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mariadb -e "CREATE USER IF NOT EXISTS $DB_USER@'localhost' IDENTIFIED BY '$DB_PASS';"
mariadb -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'%' IDENTIFIED BY '$DB_PASS';"
mariadb -e "FLUSH PRIVILEGES;"

mariadb-admin -u root password "$DB_PASS"
mariadb-admin -u root -p"$DB_PASS" shutdown

mariadbd-safe
