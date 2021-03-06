#!/bin/bash
#barra
barra () {
#cd /etc/newadm && bash menu --barra
bash /etc/newadm/menu --barra
}
#color
color () {
[[ ! -e /usr/bin/trans ]] && wget -O /usr/bin/trans https://git.io/trans &> /dev/null
[[ -e "/etc/newadm/idioma" ]] && id2=$(cat /etc/newadm/idioma) || id2=es
texto3=$(source trans -b es:${id2} "${@:2}")
COLOR=$1
echo -e "${COLOR}$(source trans -b es:${id2} "${@:2}")\033[0m"
}
#idioma
idioma () {
barra
color ${Morado} "Cambiar Idioma Del Script"
barra
color ${green} "[1]" && color ${red} ">" && color ${cyan} "Cambiar Idioma"
color ${green} "[2]" && color ${red} ">" && color ${cyan} "Salir del Script"
read -p "Opción: 》" opcion
case $opcion in
0)exit 0;;
1)
color ${yellow} "Ingresé su idioma en iniciales"
color ${cyan} "Por ejemplo: pt es en in"
read -p "Idioma: 》" lang
sed -i "s;id=es;id=$lang;g" $scriptname
color ${green} "Idioma Cambiado Correctamente"
;;
2)exit 0;;
esac
}
#Colores Claro
plain='\033[0m'
red='\033[1;31m'
green='\033[1;32m'
yellow='\033[1;33m'
blue='\033[1;34m'
purple='\033[1;35m'
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

barra
color ${Rojo} "Muchas Gracias Por Usar este Script"
barra
color ${Verdecana} "Gracias de Todo Corazón"
