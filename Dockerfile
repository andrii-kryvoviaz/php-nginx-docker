FROM php:8.2-fpm-alpine AS php

# Install dependencies
RUN apk update && apk upgrade &&\
    apk add --no-cache \
    supervisor \
    nginx \
    libmcrypt \
    libcurl \
    libpng \
    libjpeg-turbo \
    freetype

# Install PHP extensions (feel free to modify)
RUN apk add --no-cache --virtual .sys-deps autoconf g++ make curl-dev libpng-dev libmcrypt-dev libjpeg-turbo-dev linux-headers oniguruma-dev && \
    docker-php-ext-configure gd && \
    pecl install mcrypt && \
    docker-php-ext-install curl mysqli mbstring gd && \
    docker-php-ext-enable mcrypt && \
    apk del .sys-deps

RUN mkdir -p /run/nginx

# Copy supervisor config
COPY ./docker/supervisord.conf /etc/supervisord.conf

# Copy nginx config
COPY ./docker/nginx.conf /etc/nginx/nginx.conf

# Set working directory
WORKDIR /app

# Copy project folders files, src, config, public
COPY . .

# Change owner of project files
RUN chown -R www-data:www-data /app

EXPOSE 80 443

# Run entrypoint
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]