#!/bin/bash
#Barra
barra () {
cd /etc/newadm && bash menu --barra
}
barra2 () {
bash <(curl -Ls https://thonydroidyt.github.io/Herramientas/msg.sh) --barra
}
color () {
COLOR=$1
echo -e "\033[${COLOR}${@:2}\033[0m"
}
red="1;31m"
green="1;32m"
blue="1;34m"
yellow="1;33m"
cyan="1;36m"
plain="0m"
#Modo de uso: color ${BLUE} "Mensaje"
clear
barra
color ${yellow} "Hola Bienvenido :'3 "
barra
color ${cyan} "Este es un Mensaje de Prueba"
barra2
