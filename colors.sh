#!/bin/bash
#Barra
barra () {
cd /etc/newadm && bash menu --barra
}
color () {
COLOR=$1
echo -e "\033[${COLOR}${@:2}\033[0m"
}
red="\e[1;31m"
green="\e[1;32m"
blue="\e[1;34m"
yellow="\e[1;33m"
cyan="\e[1;36m"
plain="\e[0m"
#color ${BLUE} "Mensaje"
barra
color ${blue} "Hola Bienvenido :'3 "
barra
color ${cyan} "Este es un Mensaje de Prueba"

