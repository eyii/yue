#!/usr/bin/env bash
tee /root/.bashrc<<-'EOF'
    alias da='docker attach xdebug'
    alias dall='docker ps -a'
    alias db='docker build -t dockerliweipei/xdebug:xdebug7.0 .'
    alias de='docker exec -it xdebug /bin/bash'
    alias dl='docker logs xdebug'
    alias dr='docker rm $(docker ps -a -q)'
    alias dp='docker push dockerliweipei/xdebug:php7.0'
    alias drun='docker run  -d --privileged -p 80:80 -p 8222:22 --name php dockerliweipei/xdebug:xdebug7.0'
    alias ds='docker stop $(docker ps -a -q)'
EOF