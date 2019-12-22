#!/bin/bash
if [ ! -d /var/www/html/lychee ]
    then
    unzip master.zip
    mv Lychee-master /var/www/html/lychee
    chown -R www-data:www-data /var/www/html/lychee
fi

/usr/sbin/apachectl start
