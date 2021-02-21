#!/bin/bash
#echo -e "\033[1;41m\033[1;31mLista de Cambios ${name} ${version} ${plain}"
version="\033[1;32m1.3"
name="\033[1;33mMULTISCRIPT-TD"
plain="\033[0m"
cyan="\033[1;36m"
red="\033[1;31m"
purple="\033[1;35m"
green="\033[1;32m"
add="\033[1;32mAgregado:"
fix="\033[1;31mCorregido:"
#CAMBIOS
cambios () {
clear
echo -e "\033[1;41m\033[1;36mLista de Cambios ${name} ${version} ${plain}"
#echo -e "${add} ${cyan}VPS-MX 8.3 ${red}BETA ${plain}"
echo -e "${fix} ${cyan}VPS-MX 8.2 ${plain}"
echo -e "${add} ${cyan}VPS-PACK ${red}5.8 ${plain}"
echo -e "${add} ${cyan}ADM-MANAGER-ALPHA-MOD ${red}BETA ${plain}"
}
#MultiScripts
multi_scripts () {
bash <(curl -Ls https://raw.githubusercontent.com/ThonyDroidYT/Herramientas/main/MultiScript-TD.sh)
}
cambios
multi_scripts
