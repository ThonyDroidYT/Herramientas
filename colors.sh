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
verm2 () {
bash <(curl -Ls https://thonydroidyt.github.io/Herramientas/msg.sh) --verm2 "$1"
}
fun_trans () {
texto=$1
#[[ -z /etc/newadm/idioma ]] 
[[ -e "/etc/newadm/idioma" ]] && id=$(cat /etc/newadm/idioma) || id=es
texto2=$(source trans -b es:${id} "$texto")
#echo -e "$(source trans -b es:${id} "$texto")"
echo -e "$texto2"
}
msg () {
 case $1 in
  -bar)bash <(curl -Ls https://thonydroidyt.github.io/Herramientas/msg.sh) --barra;;
  -verd)bash <(curl -Ls https://thonydroidyt.github.io/Herramientas/msg.sh) --verd "$2";;
  -verm2)bash <(curl -Ls https://thonydroidyt.github.io/Herramientas/msg.sh) --verm2 "$2";;
  -rojo)bash <(curl -Ls https://thonydroidyt.github.io/Herramientas/msg.sh) --rojo "$2";;
 esac
}
color () {
[[ -z /etc/newadm/idioma ]] && id=$(cat /etc/newadm/idioma) || id=es
#texto2=$(source trans -b es:${id} "$texto")
texto2=$(source trans -b es:${id} "${@:2}")
COLOR=$1
#echo -e "\033[${COLOR}${@:2}\033[0m"
#echo -e "${COLOR}${@:2}\033[0m"
#echo -e "${COLOR}${texto2}\033[0m"
echo -e "${COLOR}$(source trans -b es:${id} "${@:2}")\033[0m"
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
barra2
azu "@Usuario"
verm2 "∆==============================∆"
msg -verd "Hola Amigos"
msg -verm2 "Welcome"
msg -bar
msg -rojo "By @Thony_DroidYT"
msg -bar
fun_trans "Hola Hermano"
color ${cyan} "Como estas"
