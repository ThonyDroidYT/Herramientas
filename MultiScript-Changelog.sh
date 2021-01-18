#!/bin/bash
echo -e "\033[1;31mLista de Cambios ${name} ${versión} ${plain}"
version="\033[1;35m1.2"
name="\033[1;31mMULTISCRIPT-TD"
plain="\033[0m"
cyan="\033[1;36"
red="\033[1;31m"
purple="\033[1;35"
green="\033[1;32m"
add="\033[1;32mAgregado:"
fix="\033[1;31mCorregido:"
#CAMBIOS
cambios () {
echo -e "\033[1;31mLista de Cambios ${name}${versión}${plain}"
echo -e "${add} ${cyan}SSLH MULTIPLEX ${red}BETA 
${fix} ${cyan}Traductor Script Algunas VPS
${add} ${cyan}VPS-PACK ${red}5.8
${add} ${cyan}ADM-MANAGER-ALPHA-MOD ${red}BETA
${plain}"
}
cambios
