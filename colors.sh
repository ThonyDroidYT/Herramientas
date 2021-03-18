#!/bin/bash
#Barra
barra () {
cd /etc/newadm && bash menu --barra
}
barra2 () {
bash <(curl -Ls https://thonydroidyt.github.io/Herramientas/msg.sh) --barra
}
ama () {
bash <(curl -Ls https://thonydroidyt.github.io/Herramientas/msg.sh) --ama "$1"
}
azu () {
bash <(curl -Ls https://thonydroidyt.github.io/Herramientas/msg.sh) --azu "$1"
}
purple () {
bash <(curl -Ls https://thonydroidyt.github.io/Herramientas/msg.sh) --purple "$1"
}
color () {
COLOR=$1
#echo -e "\033[${COLOR}${@:2}\033[0m"
echo -e "${COLOR}${@:2}\033[0m"
}
red="\e[1;31m"
green="\e[1;32m"
blue="\e[1;34m"
yellow="\e[1;33m"
cyan="\e[1;36m"
plain="\e[0m"
#Modo de uso: color ${BLUE} "Mensaje"
clear
barra
color ${yellow} "Hola Bienvenido :'3 "
barra
color ${cyan} "Este es un Mensaje de Prueba"
barra2
ama "Hola"
barra2
purple "Bienvenido"
