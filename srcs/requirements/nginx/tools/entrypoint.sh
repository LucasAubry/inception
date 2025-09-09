#!/bin/sh

#genere le certificat ssl
if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.crt \
        -subj "/C=FR/ST=France/L=Paris/O=42/OU=42/CN=${DOMAIN_NAME}"
fi

#remplace le nom de domiane dans la config
sed -i "s/DOMAIN_NAME/${DOMAIN_NAME}/g" /etc/nginx/nginx.conf

exec "$@"
