#!/bin/sh -e
service mysql start
mysql -e 'CREATE DATABASE wordpress'
service apache2 start
