FROM richarvey/nginx-php-fpm:latest

WORKDIR /app

# RUN docker-php-ext-install bcmath mysqli pdo pdo_mysql

COPY . .

# RUN composer config --no-plugins allow-plugins.php-http/discovery true

# RUN /usr/local/bin/composer install
# RUN chmod -R 777 /app/storage
# CMD ["sh","-c", "php-fpm"]

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

COPY 00-laravel-deploy.sh /00-laravel-deploy.sh

RUN chmod +x 00-laravel-deploy.sh

RUN --mount=type=secret,id=_env,dst=/etc/secrets/.env cat /etc/secrets/.env
# Allow composer to run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

ENTRYPOINT ["/bin/bash", "-c", "echo 'Running setup commands'; ./00-laravel-deploy.sh"]
CMD ["/start.sh"]

