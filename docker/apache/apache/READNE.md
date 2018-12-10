


sudo tee /root/.bashrc<<-'EOF'
# .bashrc
# User specific aliases and functions
alias i='yongli'
alias v='db'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias da='docker attach ${v}'
alias dall='docker ps -a'
alias db='docker build  --compress -t dockerla02/${i}:${v} .'
alias de='docker exec -it ${v} bash'
alias dl='docker logs ${v}'
alias dp='docker push dockerla02/${i}:${v}'
alias dcb='docker-compose up -d --build'
alias dcp='docker-compose push'
alias dr='docker rm $(docker ps -a -q)'
alias drmi='docker rmi $(docker images | awk "{print $3}")'
alias drun='docker run -d --privileged -p 3306:3306  --name ${v} dockerla02/${i}:${v}'
alias ds='docker stop $(docker ps -a -q)'
alias dver='set ver="web"'
alias gr='git fetch --all &&git reset --hard origin/master'
alias ff='nohup firefox'
alias tg='env QT_IM_MODULE=ibus nohup /opt/telgram/telgrem -- %u'
alias word='nohup /opt/wps/wps'
alias excel='nohup /opt/wps/et'
alias lla="ll|awk '{print \$9}'"

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
EOF
source /root/.bashrc





cat /root/.bashrc
export v='db'


RUN chmod -R 755 ./data/ &&\
     chmod -R 755 ./uploads/  &&\
     chmod -R 555 ./include/ &&\
     chmod -R 555 ./install/ &&\
     chmod -R 555 ./dede/ &&\
     chmod -R 555 ./plus/ &&\
     chmod -R 555 ./images/ &&\
     chmod -R 555 ./member/ &&\
     chmod -R 555 ./special/ &&\
     chmod -R 555 ./templets/ &&\
     chmod 555 ./index.php  &&\
     chmod 555 ./tags.php &&\
     
/etc/apache2/sites-enabled/000-default.conf
     