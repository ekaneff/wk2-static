#!/bin/sh

DIRECTORY="/var/www/html/static"

if [ ! -d "$DIRECTORY" ]; then
	cd /var/www/html
	mkdir static
	cd /
fi