#!/bin/bash
# 12/11/2020
# THONY_DROIDYT

#COLORES
red='\033[1;31m'
green='\033[1;32m'
yellow='\033[1;33m'
cyan='\033[1;36m'
plain='\033[0m'
#NUMEROS
num0='\033[1;32m [0] \033[1;31m>'
num1='\033[1;32m [1] \033[1;31m>'
num2='\033[1;32m [2] \033[1;31m>'
num3='\033[1;32m [3] \033[1;31m>'
num4='\033[1;32m [4] \033[1;31m>'
num5='\033[1;32m [5] \033[1;31m>'
num6='\033[1;32m [6] \033[1;31m>'
num7='\033[1;32m [7] \033[1;31m>'
num8='\033[1;32m [8] \033[1;31m>'
num9='\033[1;32m [9] \033[1;31m>'
num10='\033[1;32m [10] \033[1;31m>'
num11='\033[1;32m [11] \033[1;31m>'
num12='\033[1;32m [12] \033[1;31m>'

#BARRA
barra='\033[1;34m=========================================================\033[0m'
#LOGO
admplus='\033[1;32m [NEW-ADM-PLUS] \033[0m'

#INICIO MENU
menu () {
v2-ui
}
iniciar () {
v2-ui start
}
parar () {
v2-ui stop
}
reiniciar () {
v2-ui restart
}
estado () {
v2-ui status
}
activar () {
v2-ui enable
}
desactivar () {
v2-ui disable
}
registro () {
v2-ui log
}
actualizar () {
v2-ui update
}
instalar () {
v2-ui install
}
desinstalar () {
v2-ui uninstall
}

#echo -e "${barra}"
#}
#v2ui_menu

# EJECUCIÓN DEL MENU
#v2ui_menu () {
echo -e "${barra}"
echo -e "${cyan} ADMINISTRAR PANEL WEB V2RAY ${admplus}"
echo -e "${barra}"
echo -e "${green} [1] ${red}> ${cyan}MENU V2-UI ${plain}"
echo -e "${green} [2] ${red}> ${cyan}INICIAR V2-UI ${plain}"
echo -e "${green} [3] ${red}> ${cyan}PARAR V2-UI ${plain}"
echo -e "${green} [4] ${red}> ${cyan}REINICIAR V2-UI ${plain}"
echo -e "${green} [5] ${red}> ${cyan}VER ESTADO V2-UI ${plain}"
echo -e "${green} [6] ${red}> ${cyan}ACTIVAR V2-UI ${plain}"
echo -e "${green} [7] ${red}> ${cyan}DESACTIVAR V2-UI ${plain}"
echo -e "${green} [8] ${red}> ${cyan}VER REGISTRO V2-UI ${plain}"
echo -e "${green} [9] ${red}> ${cyan}ACTUALIZAR V2-UI ${plain}"
echo -e "${green} [10] ${red}> ${cyan}INSTALAR V2-UI ${plain}"
echo -e "${green} [11] ${red}> ${cyan}DESINSTALAR V2-UI ${plain}"
echo -e "${num0} SALIR DE SCRIPT ${plain}"
echo -e "${barra}"
while [[ ${panelv2rayadm} != @(0|[1-11]) ]]; do
read -p "Escoge una Opcion [0-11]: 》" panelv2rayadm
tput cuu1 && tput dl1
done
case $panelv2rayadm in
1)menu;;
2)v2-ui start;;
3)parar;;
4)reiniciar;;
5)estado;;
6)activar;;
7)desactivar;;
8)registro;;
9)actualizar;;
10)instalar;;
11)desinstalar;;
0)exit;;
esac
