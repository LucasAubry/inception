#!/bin/sh

wp_dir='/var/www/html'

sleep 4

if [ ! -e "${wp_dir}/wp-config.php" ]
then

	wp config create	--allow-root \
						--dbname=$DB_NAME \
						--dbuser=$DB_USER \
						--dbpass=$DB_PASS \
						--dbhost=mariadb:3306 \
						--path=$wp_dir

	wp core install		--allow-root \
						--url=$WP_URL \
						--title=$WP_TITLE \
						--admin_email=$WP_ADMIN_EMAIL \
						--admin_user=$WP_ADMIN \
						--admin_password=$WP_ADMIN_PASS \
						--path=$wp_dir

    wp user create		--allow-root \
						$WP_USER $WP_USER_EMAIL \
						--user_pass=$WP_USER_PASS \
						--path=$wp_dir
fi

/usr/sbin/php-fpm81 -F
