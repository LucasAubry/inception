#!/bin/sh
# give www-data ownership to mounted volume
chown -R www-data:www-data /var/www/html || true
# exec the main process (php-fpm)
exec "$@"

