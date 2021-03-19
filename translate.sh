#!/bin/bash
color () {
[[ -e "/etc/newadm/idioma" ]] && id2=$(cat /etc/newadm/idioma) || id2=es
#texto2=$(source trans -b es:${id} "$texto")
texto3=$(source trans -b es:${id2} "${@:2}")
COLOR=$1
#echo -e "\033[${COLOR}${@:2}\033[0m"
#echo -e "${COLOR}${@:2}\033[0m"
#echo -e "${COLOR}${texto3}\033[0m"
echo -e "${COLOR}$(source trans -b es:${id2} "${@:2}")\033[0m"
}
red="\e[1;31m"
green="\e[1;32m"
blue="\e[1;34m"
yellow="\e[1;33m"
cyan="\e[1;36m"
plain="\e[0m"
