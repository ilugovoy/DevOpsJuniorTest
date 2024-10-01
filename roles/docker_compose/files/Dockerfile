# Используем официальный образ PHP с поддержкой FPM
FROM php:7.4-fpm
WORKDIR /var/www/html
RUN apt-get update && apt-get install -y procps curl
COPY ./src /var/www/html
CMD ["php-fpm"]
