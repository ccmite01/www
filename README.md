This docker image provides a web server and picture db.


# To simply use the latest stable version, run
docker run -d -v /opt/web/root:/var/www/html -v /opt/web/lychee:/var/www/html/lychee --name www ccmite/www


# Example Docker Compose app

* docker-compose.yml

<pre>
version: '2.2'
services:
# Web Server ###################################################
  www:
    image: ccmite/www:latest
    container_name: www
    hostname: www
    tty: true
    restart: always
    ports:
      - '80:80'
    volumes:
      - '/opt/web/root:/var/www/html'
      - '/opt/web/lychee:/var/www/html/lychee'
      - '/opt/minecraft/dynmapweb:/var/www/html/map'
    environment:
      LANG: ja-JP.UTF-8
      LYCHEE_DB_HOST: "lyc:3306"
    depends_on:
      - lyc
    mem_limit: 256m
# lychee DB Server ##############################################
  lyc:
    image: ccmite/db:latest
    container_name: lyc
    hostname: lyc
    tty: true
    restart: always
    ports:
      - '3310:3306'
    volumes:
      - '/share/11LYC/mysql:/var/lib/mysql'
    environment:
      MARIADB_ROOT_PASSWORD: do_not_copy_and_paste
      MARIADB_DATABASE: lychee
      MARIADB_INITDB_SKIP_TZINFO: "true"
      LANG: ja-JP.UTF-8
    mem_limit: 256m
</pre>
