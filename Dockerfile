FROM php:8.0.25-fpm-alpine

WORKDIR /app

RUN docker-php-ext-install bcmath mysqli pdo pdo_mysql

COPY . .

# RUN composer config --no-plugins allow-plugins.php-http/discovery true

# RUN /usr/local/bin/composer install
RUN chmod -R 777 /app/storage
# CMD ["sh","-c", "php-fpm"]

