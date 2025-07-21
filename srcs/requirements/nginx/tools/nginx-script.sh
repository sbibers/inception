#!/bin/bash

echo "Creating nginx SSL certificate ..."

openssl req \
    -x509 \
    -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -subj "/C=NL/ST=Holland/L=Amsterdam/O=Codam/CN=sbibers.42.fr" \
    -out "/etc/nginx/ssl/secret.crt" \
    -keyout "/etc/nginx/ssl/secret.key"

echo "Starting nginx ..."
exec nginx -g "daemon off;"