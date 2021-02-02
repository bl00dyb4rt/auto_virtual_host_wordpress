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
        echo "${GREEN}Creando el directorio ${NC}$ROOT_HTML$DOMAIN"
        sudo mkdir -v $ROOT_HTML$DOMAIN
    
        echo "${GREEN}Moviendo wordpress.tar.gz"
        sudo mv -v latest.tar.gz $ROOT_HTML$DOMAIN
    
        echo "${GREEN}Descomprimiendo $ROOT_HTML$DOMAIN/latest.tar.gz"
        sudo tar -zxf $ROOT_HTML$DOMAIN"/latest.tar.gz" -C $ROOT_HTML$DOMAIN --no-same-owner
    
        echo "${RED}Eliminando innecesarios"    
        sudo rm -v $ROOT_HTML$DOMAIN"/latest.tar.gz"
        sudo mv -v $ROOT_HTML$DOMAIN"/wordpress" $ROOT_HTML$DOMAIN"/public_html"
    
        echo "${GREEN}Cambiando 755 directorios  $ROOT_HTML$DOMAIN/public_html"
        sudo find $ROOT_HTML$DOMAIN"/public_html" -type d -exec chmod 755 {} \;
    
        echo "${GREEN}Cambiando 644 ficheros  $ROOT_HTML$DOMAIN/public_html"
        sudo find $ROOT_HTML$DOMAIN"/public_html" -type f -exec chmod 644 {} \;

        echo "${NC}Cambiando owner $USER_WEBSERVER:$GROUP_WEBSERVER  en $ROOT_HTML$DOMAIN/public_html"
        sudo chown -R  $USER_WEBSERVER:$GROUP_WEBSERVER $ROOT_HTML$DOMAIN"/public_html";
        ls -al $ROOT_HTML$DOMAIN"/public_html"
    
    else
        echo "${RED}El directorio/dominio ya existe: $ROOT_HTML$DOMAIN"
    fi

else
   echo  "${RED}Ingrese un dominio"
fi

