FROM dockerla03/apache:php7.0
RUN pecl install xdebug-2.5.5&&docker-php-ext-enable xdebug
RUN echo -e '\n\
[xdebug] \n\
xdebug.idekey= PHPSTORM \n\
xdebug.remote_enable = 1 \n\
xdebug.remote_connect_back = on \n\
#xdebug.remote_port = 9999 \n\
 '>>/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN apt install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh

RUN sed -ri 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd

ADD authorized_keys /root/.ssh/authorized_keys
ADD run.sh /run.sh
RUN chmod 755 /run.sh





EXPOSE 80 22