#!/bin/bash
if [ ! -d /var/www/html/lychee ]
    then
    cd /var/www/html
    unzip /master.zip
    mv Lychee-master lychee
    chown -R www-data:www-data /var/www/html/lychee
fi

/usr/sbin/apachectl start
