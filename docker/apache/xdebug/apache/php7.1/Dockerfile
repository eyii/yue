FROM php:7.1.18-apache

#ADD  https://mirrors.ustc.edu.cn/repogen/conf/debian-https-4-stretch /etc/apt/sources.list
RUN apt-get update -y&&apt-get install -y wget zip unzip apt-utils git libfreetype6-dev   libjpeg62-turbo-dev   libmcrypt-dev  libpng-dev
RUN docker-php-ext-install -j$(nproc) iconv mcrypt gd  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ &&docker-php-ext-install pdo_mysql mysqli

#git
WORKDIR /var/www/html
#ENV GIT
#RUN git init && git remote add origin ${GIT}
RUN sh /root/.bashrc
#RUN git pull origin master
RUN sed -i "1i\alias gr='git fetch --all&&git reset --hard origin/master'" /root/.bashrc


#vhost
ENV APACHE_CONFDIR /etc/apache2
WORKDIR /etc/apache2/sites-enabled/
ENV APACHE_DOCUMENT_ROOT /var/www/html
RUN mkdir -p ${APACHE_DOCUMENT_ROOT}
ADD index.php ${APACHE_DOCUMENT_ROOT}
RUN sed -i 's/#ServerName www.example.com/ServerName s.cn/' 000-default.conf
RUN sed -i "s#DocumentRoot /var/www/html#DocumentRoot ${APACHE_DOCUMENT_ROOT}#" 000-default.conf

#tools
RUN  mkdir -p /root/tools
WORKDIR /root/tools
RUN ln -s /etc/apache2/sites-enabled vhost
RUN ln -s /etc/apache2/apache2.conf  apache2.conf
RUN ln -s ${APACHE_DOCUMENT_ROOT} web

#composer
WORKDIR /var/www/html
RUN php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer
WORKDIR /root/tools
EXPOSE 80