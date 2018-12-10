FROM dockerla03/xdebug:apache7.0
ENV WEB /var/www/html
RUN apt-get install -y iputils-ping cron mysql-client
WORKDIR ${WEB}
#mysql-client
EXPOSE 80
CMD /usr/sbin/cron&apache2-foreground



#ADD tools/docker-php-entrypoint.sh /usr/local/bin/docker-php-entrypoint



#组件
#RUN apt-get install -y gcc g++  libiconv-hook-dev libxml2-dev  libcurl4-openssl-dev
#RUN docker-php-ext-install zip  pcntl sockets  sysvmsg sysvsem sysvshm shmop soap  opcache  xmlrpc
#RUN pecl install swoole &&docker-php-ext-enable swoole
#RUN php --ri swoole
