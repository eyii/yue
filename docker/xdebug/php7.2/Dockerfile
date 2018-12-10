FROM dockerla03/apache:php7.2
RUN pecl install xdebug-2.6.0&&docker-php-ext-enable xdebug
RUN echo  -e '\n\
[xdebug] \n\
xdebug.idekey= PHPSTORM \n\
xdebug.remote_enable = 1 \n\
xdebug.remote_connect_back = on \n\
#xdebug.remote_port = 9999 \n\

 '>>/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

EXPOSE 80