FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
libpq-dev \
&& docker-php-ext-install pgsql pdo_pgsql \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*


COPY index.php /var/www/html/

RUN sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf
RUN sed -i 's/*:80/*:8080/g' /etc/apache2/sites-available/000-default.conf

EXPOSE 80
