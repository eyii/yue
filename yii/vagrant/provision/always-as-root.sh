#!/usr/bin/env bash
rm -f  /etc/php/7.0/fpm/conf.d/20-xdebug.ini
ln -s /app/vagrant/php/20-xdebug.ini /etc/php/7.0/fpm/conf.d/20-xdebug.ini
source /app/vagrant/provision/common.sh

#== Provision script ==

info "Provision-script user: `whoami`"

info "Restart web-stack"
service php7.0-fpm restart
service nginx restart
service mysql restart