FROM php:7.4.0-apache-buster
LABEL maintainer="ccmite"
WORKDIR /
COPY start.sh /
RUN : "add package" && \
    apt --allow-releaseinfo-change update && apt install -y \
    locales \
    zip \
    zlib1g-dev \
    libpng-dev \
    libzip-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    chmod +x /start.sh && \ 
    curl -s -k -L --tlsv1.2 https://github.com/electerious/Lychee/archive/master.zip -o master.zip && \ 
    sed -i 's/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/g' /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    update-locale LANG=ja_JP.UTF-8 && \
    rm -f /etc/localtime && \
    ln -s /usr/share/zoneinfo/Japan /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    docker-php-ext-install -j$(nproc) gd exif zip mysqli && \
    echo '[PHP]' > /usr/local/etc/php/php.ini  && \
    echo 'max_execution_time = 200' >> /usr/local/etc/php/php.ini  && \
    echo 'post_max_size = 100M' >> /usr/local/etc/php/php.ini  && \
    echo 'upload_max_size = 100M' >> /usr/local/etc/php/php.ini  && \
    echo 'upload_max_filesize = 20M' >> /usr/local/etc/php/php.ini  && \
    echo 'memory_limit = 256M' >> /usr/local/etc/php/php.ini  && \
    echo '[Date]' >> /usr/local/etc/php/php.ini  && \
    echo 'date.timezone = Asia/Tokyo' >> /usr/local/etc/php/php.ini

ENV LANG="ja-JP.UTF-8" LYCHEE_DB_HOST="lyc:3306" SITE_NAME="example.com"

ENTRYPOINT ["sh", "/start.sh"]
EXPOSE 80
