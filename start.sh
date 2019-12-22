#!/bin/bash
sed -i "s/#ServerName www.example.com/ServerName ${SITE_NAME}/g" /etc/apache2/sites-available/000-default.conf
sed -i '/#Include conf-available\/serve-cgi-bin.conf/Include conf-available\/serve-cgi-bin.conf/g' /etc/apache2/sites-available/000-default.conf && \
if [ ! -d /var/www/html/lychee ]
    then
    cd /var/www/html
    unzip /master.zip
    mv Lychee-master lychee
    chown -R www-data:www-data /var/www/html/lychee
fi

/usr/sbin/apachectl -D FOREGROUND
