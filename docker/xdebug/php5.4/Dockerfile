FROM centos
RUN yum update -y
RUN yum install -y epel-release wget git
RUN yum install -y php php-mysql php-gd libjpeg* php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-bcmath php-mhash php-fpm

#nginx php-fpm
RUN yum install -y nginx
RUN mkdir -p /www/web/s.cn/public
RUN mkdir -p /www/logs
RUN echo  -e $'\n\
    server {   \n\
        listen       80;   \n\
        server_name  s.cn;  \n\
        location / {   \n\
            root   /www/web/s.cn/public;  \n\
            proxy_set_header Host $host; \n\
            proxy_set_header X-Real-IP $remote_addr;  \n\
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; \n\
            index  index.html index.htm index.php;  \n\
        }  \n\
        location ~ \.php$ {  \n\
            root /www/web/s.cn/public;  \n\
            fastcgi_pass   127.0.0.1:9000; \n\
            fastcgi_index  index.php;  \n\
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name; \n\
            include        fastcgi_params;  \n\
        } \n\
        error_log /www/logs/s.cn.log;  \n\
}  ' >/etc/nginx/conf.d/s.cn.conf

#git
RUN cd /www/web/s.cn &&rm -rf /www/web/s.cn/*
WORKDIR /www/web/s.cn
RUN git init && git remote add origin
RUN echo $"alias gr='git fetch --all&&git reset --hard origin/master' ">/root/.bashrc
RUN source /root/.bashrc
RUN git fetch --all&&git reset --hard origin/master

#xdebug
RUN yum install -y php-pecl-xdebug
RUN echo -e $'\n\
[xdebug] \n\
xdebug.idekey= PHPSTORM \n\
xdebug.remote_enable = 1 \n\
xdebug.remote_connect_back = on \n\
xdebug.remote_autostart = off \n\
xdebug.remote_host = "127.0.0.1" \n\
xdebug.remote_log = x-debug-remote.log \n\
zend_extension=/usr/lib64/php/modules/xdebug.so  \n\
xdebug.profiler_append = 0  \n\
xdebug.profiler_enable = 1  \n\
xdebug.profiler_enable_trigger = 0  \n\
 '>/etc/php.d/xdebug.ini
#xdebug.remote_port = 9999 \n\
#ssh
RUN yum install -y openssh-server
RUN sed -i 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN ssh-keygen -t rsa -f  /etc/ssh/ssh_host_rsa_key  -N ""
RUN ssh-keygen -t ecdsa -f  /etc/ssh/ssh_host_ecdsa_key  -N ""
RUN ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ""
WORKDIR /root
#tools
RUN mkdir tools
RUN cd tools && ln -s /etc/nginx/conf.d/ vhost && ln -s  /www/web web

#lnmp.sh
WORKDIR /root/tools
RUN echo $'#!/bin/bash \n\
nginx && php-fpm -D && /usr/sbin/sshd -D & \n\
'>lnmp.sh
RUN chmod +x lnmp.sh
EXPOSE 80  22
#ENTRYPOINT  ./lnmp.sh
CMD /etc/init.d/apache2 start