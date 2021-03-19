#!/bin/bash
color () {
[[ -e "/etc/newadm/idioma" ]] && id2=$(cat /etc/newadm/idioma) || id2=es
texto3=$(source trans -b es:${id2} "${@:2}")
COLOR=$1
echo -e "${COLOR}$(source trans -b es:${id2} "${@:2}")\033[0m"
}
#Colores Claro
plain='\033[0m'
red='\033[1;31m'
green='\033[1;32m'
yellow='\033[1;33m'
blue='\033[1;34m'
purple='\033[1;35m
cyan='\033[1;36m'
white='\033[1;37m'
#Fondo Bash
Gris="\033[1;100m"
Rojo="\033[1;41m"
Azul="\033[44m"
Morado="\033[45m"
Blanco="\033[47m"
Morado2="\033[105m"
Celeste="\033[46m"
Verde="\033[102m"
Verdecana="\033[42m"
color ${Rojo} "Muchas Gracias Por Usar este Script"
