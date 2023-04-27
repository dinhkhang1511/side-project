FROM richarvey/nginx-php-fpm:2.0.4

COPY . .

# Image config
ENV SKIP_COMPOSER 1
ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1

# Laravel config
ENV APP_ENV production
ENV APP_DEBUG false
ENV LOG_CHANNEL stderr

# Allow composer to run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN php -d memory_limit=-1 /usr/local/bin/composer install
RUN chmod -R 777 /app/storage

CMD ["sh","-c", "php-fpm", "/start.sh"]
