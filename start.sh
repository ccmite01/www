#!/bin/bash
sed -i "s/#ServerName www.example.com/ServerName ${SITE_NAME}/g" /etc/apache2/sites-available/000-default.conf

if [ ! -d /var/www/html/lychee ]
    then
    cd /var/www/html
    unzip /master.zip
    mv Lychee-master lychee
    chown -R www-data:www-data /var/www/html/lychee
fi
sed -i "s/imagejpeg/imagepng/g" /var/www/html/lychee/php/Modules/Photo.php
sed -i "s/quality = 90;/quality = 9;/g" /var/www/html/lychee/php/Modules/Photo.php

/usr/sbin/apachectl -D FOREGROUND
