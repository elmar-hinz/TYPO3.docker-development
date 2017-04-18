FROM php:7-apache
MAINTAINER Elmar Hinz <t3elmar@gmail.com>

# Load packages

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    wget \
    libxml2-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    zlib1g-dev \
    graphicsmagick

# Configure PHP

RUN docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) mysqli soap gd zip opcache
RUN echo 'always_populate_raw_post_data = -1\nmax_execution_time = 240\nmax_input_vars = 1500\nupload_max_filesize = 32M\npost_max_size = 32M' \
    > /usr/local/etc/php/conf.d/typo3.ini

# Configure Apache

RUN a2enmod rewrite
RUN apt-get clean
RUN apt-get -y purge \
    libxml2-dev libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    zlib1g-dev
RUN rm -rf /var/lib/apt/lists/* /usr/src/*

# Setup directories

RUN cd /var/www/html
RUN mkdir typo3_src
RUN ln -s typo3_src/index.php
RUN ln -s typo3_src/typo3
RUN ln -s typo3_src/_.htaccess .htaccess
RUN mkdir typo3temp
RUN mkdir typo3conf
RUN mkdir fileadmin
RUN mkdir uploads
RUN touch FIRST_INSTALL
RUN chown -R www-data. .

# Configure mount points

VOLUME /var/www/html/typo3_src
VOLUME /var/www/html/fileadmin
VOLUME /var/www/html/typo3conf
VOLUME /var/www/html/typo3temp
VOLUME /var/www/html/uploads

