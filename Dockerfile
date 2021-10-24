FROM php:7.4-fpm

RUN apt-get update \
    && rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
    && apt-get install -y \
    default-mysql-client wget git zip unzip vim graphviz \
    libfreetype6-dev libjpeg62-turbo-dev libpng-dev libwebp-dev \
    libcurl4-openssl-dev libssl-dev libzip-dev libfontconfig1 libxrender1 libmcrypt-dev libicu-dev libonig-dev \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd && docker-php-ext-install pdo_mysql \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) curl zip gd iconv intl json mbstring exif fileinfo \
    && pecl install xhprof && docker-php-ext-enable xhprof \
    && pecl install xdebug && docker-php-ext-enable xdebug \
    && pecl install mongodb && docker-php-ext-enable mongodb \
    && yes no | pecl install -o -f redis && docker-php-ext-enable redis \
    && rm -rf /tmp/pear

RUN wget https://getcomposer.org/installer -O - -q | php -- --install-dir=/bin --filename=composer --quiet

WORKDIR /var/www/html
