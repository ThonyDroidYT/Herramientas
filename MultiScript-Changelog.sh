#!/bin/bash
#echo -e "\033[1;31mLista de Cambios ${name} ${version} ${plain}"
version="\033[1;35m1.2"
name="\033[1;33mMULTISCRIPT-TD"
plain="\033[0m"
cyan="\033[1;36"
red="\033[1;31m"
purple="\033[1;35"
green="\033[1;32m"
add="\033[1;32mAgregado:"
fix="\033[1;31mCorregido:"
#CAMBIOS
cambios () {
echo -e "\033[1;31mLista de Cambios ${name} ${version} ${plain}"
echo -e "${add} ${cyan}SSLH MULTIPLEX ${red}BETA ${plain}"
${fix} ${cyan}Traductor Script Algunas VPS
echo -e "${add} ${cyan}VPS-PACK ${red}5.8 ${plain}"
echo -e "${add} ${cyan}ADM-MANAGER-ALPHA-MOD ${red}BETA ${plain}"
}
cambios
