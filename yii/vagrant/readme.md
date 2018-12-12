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
 