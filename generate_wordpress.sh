#!/bin/bash
GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'
ROOT_HTML='/var/www/'
USER_WEBSERVER='www-data'
GROUP_WEBSERVER='www-data'

DOMAIN=$1
if [ $# -eq 1 ];
then
    if [ ! -d $ROOT_HTML$DOMAIN ];
    then
        wget https://wordpress.org/latest.tar.gz
        echo "${GREEN}Add dir  ${NC}$ROOT_HTML$DOMAIN"
        sudo mkdir -v $ROOT_HTML$DOMAIN
    
        echo "${GREEN}Move wordpress.tar.gz"
        sudo mv -v latest.tar.gz $ROOT_HTML$DOMAIN
    
        echo "${GREEN}Untar dir $ROOT_HTML$DOMAIN/latest.tar.gz"
        sudo tar -zxf $ROOT_HTML$DOMAIN"/latest.tar.gz" -C $ROOT_HTML$DOMAIN --no-same-owner
    
        echo "${RED} Remove latest.tar.gz"    
        sudo rm -v $ROOT_HTML$DOMAIN"/latest.tar.gz"
        sudo mv -v $ROOT_HTML$DOMAIN"/wordpress" $ROOT_HTML$DOMAIN"/public_html"
    
        echo "${GREEN} Set chmod 755 to dirs in  $ROOT_HTML$DOMAIN/public_html"
        sudo find $ROOT_HTML$DOMAIN"/public_html" -type d -exec chmod 755 {} \;
    
        echo "${GREEN} Set chmod 644  to files in $ROOT_HTML$DOMAIN/public_html"
        sudo find $ROOT_HTML$DOMAIN"/public_html" -type f -exec chmod 644 {} \;

        echo "${NC} Change  owner $USER_WEBSERVER:$GROUP_WEBSERVER  in $ROOT_HTML$DOMAIN/public_html"
        sudo chown -R  $USER_WEBSERVER:$GROUP_WEBSERVER $ROOT_HTML$DOMAIN"/public_html";
        ls -al $ROOT_HTML$DOMAIN"/public_html"
    
    else
        echo "${RED} Dir: $ROOT_HTML$DOMAIN already exist"
    fi

else
   echo  "${RED} Set a domain name "
fi

