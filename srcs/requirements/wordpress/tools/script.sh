#!/bin/sh
set -e

cd /var/www/wordpress

until mariadb -h mariadb -u $SQL_USERNAME -p$SQL_PASSWORD -e "SELECT 1" > /dev/null 2>&1; do
  echo "Waiting for MariaDB to be ready..."
  sleep 5
done

if [ -z "$DOMAIN_NAME" ]; then
  echo "Error: DOMAIN_NAME is not set!"
  exit 1
fi

# Vérifier si WordPress est déjà installé
if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    echo "WordPress is not installed yet. Installing WordPress..."
    wp config create \
        --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USERNAME \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306 \
        --path='/var/www/wordpress' \
        --locale=fr_FR
else
    echo "WordPress is already installed."
fi

if ! wp core is-installed --allow-root --path='/var/www/wordpress'; then
    echo "Installing WordPress..."
    wp core install \
        --url="https://$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root \
        --path='/var/www/wordpress'

    echo "Creating WordPress user..."
    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --role=author \
        --user_pass="$WP_USER_PASSWORD" \
        --allow-root \
        --path='/var/www/wordpress'

    echo "Configuring comment settings..."
    # Enable comments by default for new posts
    wp option update default_comment_status open --allow-root --path='/var/www/wordpress'

    # Enable pingbacks and trackbacks by default
    wp option update default_ping_status open --allow-root --path='/var/www/wordpress'

    # Allow comments from users (no registration required)
    wp option update comment_registration 0 --allow-root --path='/var/www/wordpress'

    # Auto-approve comments from previously approved authors
    wp option update comment_moderation 0 --allow-root --path='/var/www/wordpress'

    # Require comment author to fill out name and email
    wp option update require_name_email 1 --allow-root --path='/var/www/wordpress'

    # Show avatars in comments
    wp option update show_avatars 1 --allow-root --path='/var/www/wordpress'

    # Set default avatar rating to G (suitable for all audiences)
    wp option update avatar_rating G --allow-root --path='/var/www/wordpress'

    # Enable threaded comments (nested replies) with 5 levels deep
    wp option update thread_comments 1 --allow-root --path='/var/www/wordpress'
    wp option update thread_comments_depth 5 --allow-root --path='/var/www/wordpress'

    # Enable comment pagination (50 comments per page)
    wp option update page_comments 1 --allow-root --path='/var/www/wordpress'
    wp option update comments_per_page 50 --allow-root --path='/var/www/wordpress'

    # Show newer comments at the top
    wp option update comment_order desc --allow-root --path='/var/www/wordpress'

    echo "Comment settings configured successfully!"
else
    echo "WordPress is already installed. Checking URL configuration..."
fi

# Ensure WordPress URLs are correctly set (in case they got misconfigured)
echo "Setting WordPress URLs to https://$DOMAIN_NAME..."
wp option update home "https://$DOMAIN_NAME" --allow-root --path='/var/www/wordpress'
wp option update siteurl "https://$DOMAIN_NAME" --allow-root --path='/var/www/wordpress'

mkdir -p /run/php

echo "Starting PHP-FPM..."
/usr/sbin/php-fpm83 -F
