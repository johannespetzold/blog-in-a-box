#!/bin/sh -xe
service mysql start
mysql -e 'CREATE DATABASE wordpress'

test -n "$DOMAIN" || (echo '$DOMAIN not set'; exit 1)
openssl req -nodes -newkey rsa:2048 -keyout ca.key -out ca.csr -subj "/C=AB/ST=State/L=City/O=Org/OU=Unit/CN=$DOMAIN"
openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt -days 3650
apache2ctl start
