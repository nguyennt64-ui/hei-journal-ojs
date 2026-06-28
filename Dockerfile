FROM php:8.2-apache

RUN apt-get update && apt-get install -y --no-install-recommends \
    default-mysql-server default-mysql-client \
    libzip-dev libpng-dev libicu-dev libonig-dev libxml2-dev \
    && docker-php-ext-install mysqli pdo_mysql zip gd intl mbstring \
    && a2enmod rewrite headers \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

COPY . /var/www/html/
COPY lib/pkp/classes/cache/ /var/www/html/lib/pkp/classes/cache/
COPY docker/health.php /var/www/html/health.php
COPY docker/php-errors.ini /usr/local/etc/php/conf.d/99-ojs-errors.ini

RUN mkdir -p /var/www/files cache public/journals/1 public/site /var/run/mysqld /var/log/mysql \
    && chown -R www-data:www-data /var/www/html /var/www/files \
    && chown -R mysql:mysql /var/run/mysqld /var/lib/mysql /var/log/mysql

COPY docker/my.cnf /etc/mysql/my.cnf
COPY docker/apache.conf /etc/apache2/sites-available/000-default.conf
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
