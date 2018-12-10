FROM php:7.0.30-apache

#ADD  https://mirrors.ustc.edu.cn/repogen/conf/debian-https-4-stretch /etc/apt/sources.list
RUN apt-get update -y&&apt-get install -y wget zip unzip apt-utils git libfreetype6-dev   libjpeg62-turbo-dev   libmcrypt-dev  libpng-dev
RUN docker-php-ext-install -j$(nproc) iconv mcrypt gd &&  docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/  &&docker-php-ext-install pdo_mysql mysqli


#git
WORKDIR /var/www/html
#ENV GIT=
#RUN git init && git remote add origin ${GIT}
RUN sed -i "1i\alias gr='git fetch --all&&git reset --hard origin/master'" /root/.bashrc
RUN sh /root/.bashrc
#RUN git pull origin master


#vhost
ENV APACHE_CONFDIR=/etc/apache2
WORKDIR /etc/apache2/sites-enabled/
ENV APACHE_DOCUMENT_ROOT=/var/www/html
RUN mkdir -p ${APACHE_DOCUMENT_ROOT}
ADD index.php ${APACHE_DOCUMENT_ROOT}
RUN sed -i 's/#ServerName www.example.com/ServerName s.cn/' 000-default.conf
RUN sed -i "s#DocumentRoot /var/www/html#DocumentRoot ${APACHE_DOCUMENT_ROOT}#" 000-default.conf



#RUN sh /etc/apache2/envvars
EXPOSE 80
#RUN apachectl restartd

#CMD /etc/init.d/apache2 start