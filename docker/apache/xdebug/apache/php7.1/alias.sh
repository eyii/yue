#!/usr/bin/env bash
v=php
alias da='docker attach ${v}'
alias dall='docker ps -a'
alias db='docker build -t dockerliweipei/xdebug:php7.1 .'
alias de='docker exec -it ${v} /bin/bash'
alias dl='docker logs ${v}'
alias dr='docker rm $(docker ps -a -q)'
alias dp='docker push dockerliweipei/xdebug:php7.1'
alias drun='docker run  -d --privileged -p 80:80 --name ${v} dockerliweipei/xdebug:php7.1'
alias ds='docker stop $(docker ps -a -q)'


tee /root/.bashrc<<-'EOF'

EOF