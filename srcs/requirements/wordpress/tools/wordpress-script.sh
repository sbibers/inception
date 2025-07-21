#!/bin/bash

sleep 5

mkdir -p /var/www/html/wordpress
touch /run/php/php8.2-fpm.pid
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*

cd /var/www/html/wordpress

if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
    echo "Install WordPress..."
    
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    
    wp core download \
        --path="/var/www/html/wordpress/" \
        --allow-root
    echo "WordPress downloaded successfully."
    
    echo "Waiting for MariaDB to be ready..."
    until mysqladmin ping -h"${WP_DATABASE_HOST}" -u"${DB_USER}" -p"${DB_USER_PASSWORD}" --silent; do
        echo "Waiting for MariaDB..."
        sleep 2
    done

    echo "Create WordPress configuration file..."
    wp config create \
        --path="/var/www/html/wordpress/" \
        --dbname="${WP_DATABASE_NAME}" \
        --dbuser="${DB_USER}" \
        --dbpass="${DB_USER_PASSWORD}" \
        --dbhost="${WP_DATABASE_HOST}" \
        --allow-root
    
    echo "Create WordPress Admin user..."
    wp core install \
        --path="/var/www/html/wordpress/" \
        --url="https://${DOMAIN_NAME}" \
        --title="inception" \
        --admin_user="${WP_ADMIN}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root
           
    echo "Create WordPress User..." 
    wp user create ${WP_USER} ${WP_USER_EMAIL} \
        --path="/var/www/html/wordpress/" \
        --user_pass="${WP_USER_PASSWORD}" \
        --role=editor \
        --allow-root

    echo "WordPress setup complete."
else
    echo "WordPress is already installed."
fi

echo "Update WordPress URLs..."
wp option update home "https://${DOMAIN_NAME}" --path="/var/www/html/wordpress/" --allow-root
wp option update siteurl "https://${DOMAIN_NAME}" --path="/var/www/html/wordpress/" --allow-root

if [ ! -f /var/www/html/wordpress/favicon.ico ]; then
    echo "Adding custom favicon..."
    touch /var/www/html/wordpress/favicon.ico
fi

chown -R www-data:www-data /var/www/html/wordpress/
chmod -R 755 /var/www/html/wordpress/

echo "Starting PHP-FPM..."
mkdir -p /run/php
chown www-data:www-data /run/php

exec /usr/sbin/php-fpm8.2 -F