FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
libpq-dev \
&& docker-php-ext-install pgsql pdo_pgsql \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# SQL Server prerequisites
RUN apt-get update && apt-get install -y \
    curl gnupg2 unixodbc-dev apt-transport-https

# Microsoft repository
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/12/prod.list \
    > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql18

# SQLSRV extensions
RUN pecl install sqlsrv pdo_sqlsrv && \
    docker-php-ext-enable sqlsrv pdo_sqlsrv

COPY index.php /var/www/html/

RUN sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf
RUN sed -i 's/*:80/*:8080/g' /etc/apache2/sites-available/000-default.conf

EXPOSE 80
