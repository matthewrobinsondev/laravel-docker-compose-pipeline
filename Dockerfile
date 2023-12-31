FROM php:8.1-fpm as PHP

ENV PHP_OPCACHE_ENABLE=0
ENV PHP_OPCACHE_ENABLE_CLI=0
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS=0
ENV PHP_OPCACHE_REVALIDATE_FREQ=0

RUN usermod -u 1000 www-data

RUN apt-get update -y
RUN apt-get install -y unzip libpq-dev libcurl4-gnutls-dev nginx zip
RUN docker-php-ext-install pdo pdo_mysql bcmath curl opcache

WORKDIR /var/www
COPY --chown=www-data . .

COPY ./docker/php/php.ini /usr/local/etc/php/php.ini
COPY ./docker/php/php-fpm.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./docker/php/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf

COPY --from=composer:2.3.5 /usr/bin/composer /usr/bin/composer

RUN curl -sLS https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install nodejs -y

RUN chmod -R 755 /var/www/storage
RUN chmod -R 755 /var/www/bootstrap

RUN touch /run/nginx.pid \
 && chown -R www-data:www-data /run/nginx.pid

RUN mkdir -p /var/lib/nginx/tmp /var/log/nginx \
    && chown -R www-data:www-data /var/lib/nginx /var/log/nginx \
    && chmod -R 755 /var/lib/nginx /var/log/nginx

ENTRYPOINT ["docker/entrypoint.sh"]
