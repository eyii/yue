sudo passwd root
/usr/lib/php/20151012/xdebug.so

ln -s /etc/init.d/php7.0-fpm /usr/bin/fpm



#VBoxManage  
cat <<EOF>> /root/.bashrc
source ~/.bashrc2  
EOF

cat <<EOF>> /root/.bashrc2 
alias vlist="VBoxManage list vms"   
alias vpf="VBoxManage controlvm \$host poweroff"  
alias vdel="VBoxManage unregistervm \$host --delete"  
EOF
 
 
 
#nginx  

/usr/sbin/nginx -g daemon on
/usr/sbin/nginx -t -q -g daemon on; master_process on;
/sbin/start-stop-daemon --quiet --stop --retry QUIT/5 --pidfile /run/nginx.pid
ps -ef|grep nginx |awk '{print $2}'|xargs kill -9
nginx -c /etc/nginx/nginx.conf
