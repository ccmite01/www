FROM php:7.4.0-apache-buster
LABEL maintainer="ccmite"
WORKDIR /

RUN : "add package" && \
    apt --allow-releaseinfo-change update && apt install -y \
    locales \
    zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    curl -s -k -L --tlsv1.2 https://github.com/electerious/Lychee/archive/master.zip -o master.zip && \ 
    mkdir -p /var/www/html/pic && \
    unzip master.zip && \
    rm -f master.zip -f && \
    mv Lychee-master /var/www/html/pic && \
    chown -R www-data:www-data /var/www/html/pic && \
    sed -i 's/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/g' /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    update-locale LANG=ja_JP.UTF-8 && \
    rm -f /etc/localtime && \
    ln -s /usr/share/zoneinfo/Japan /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    echo '[Date]' > /usr/local/etc/php/php.ini  && \
    echo 'date.timezone = "Asia/Tokyo"' >> /usr/local/etc/php/php.ini

ENV LANG="ja-JP.UTF-8" LYCHEE_DB_HOST="lyc:3306"

ENTRYPOINT ["/usr/sbin/apache2", "-D", "FOREGROUND"]
EXPOSE 80
