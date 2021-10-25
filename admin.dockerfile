FROM php:7.4-fpm

RUN apt-get update \
    && rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
    && apt-get install -y \
    default-mysql-client wget git zip unzip mc vim \
    && rm -rf /tmp/pear


WORKDIR /var/www/html
