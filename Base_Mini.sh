#!/bin/bash
#BARRA AZUL
#barra="\033[1;34m======================================================\033[0m"
#barra="\033[1;34m**********************************************************\033[0m"
barra="\033[1;34m+++++++++++++++++++++++++++++++++++++++++++++++++++++++\033[0m"
#barra="\033[1;34m###############################################\033[0m"
#barra="\033[1;34m_____________________________________________________\033[0m"
#NUMEROS
num0='\033[1;32m [0] \033[1;31m>'
num1='\033[1;32m [1] \033[1;31m>'
num2='\033[1;32m [2] \033[1;31m>'
num3='\033[1;32m [3] \033[1;31m>'
num4='\033[1;32m [4] \033[1;31m>'
num5='\033[1;32m [5] \033[1;31m>'

#COLORES
blan="\033[1;37m"
plain="\033[0m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
blue="\033[1;34m"
purple="\033[1;35m"
cyan="\033[1;36m"
#FONDO
Gris="\033[1;100m"
Rojo="\033[1;41m"
Azul="\033[44m"

#Actualizar Archivos
fun_update () {
apt-get update -y
apt-get upgrade -y
dpkg --configure -a
clear
}


echo -e "${barra}"
echo -e "${Rojo} ${cyan}       MULTISCRIPT FREE ${green}[BY: @THONY_DROIDYT]     ${plain}"
echo -e "${barra}"
echo -e "${num1} ${cyan}INSTALAR VPS-MX BY KALIX1  ${plain}"
echo -e "${num2} ${cyan}INTALAR NEW-ADM-DANKEL  ${plain}"
echo -e "${num3} ${cyan}INSTALAR VPSPACK BY POWERMX  ${plain}"
echo -e "${num4} ${cyan}INSTALAR SSHPLUS BY CRAZY_VPN  ${plain}"
echo -e "${num5} ${cyan}INSTALAR ADM-MANAGER OFICIAL FREE  ${plain}"
echo -e "${num0} ${red}SALIR DEL MULTISCRIPT ${plain}"
echo -e "${barra}"
#echo -e "${blue}SELECIONE UNA OPCIÓN: 》 ${yellow}"; read multiscripts
read -p "SELECIONE UNA OPCIÓN: 》" multiscripts
case $multiscripts in
0)
clear
exit;;
1)vpsmx;;
2)dankel;;
3)vpspack;;
4)sshplus;;
5)admoff;;
*)echo -e "${red}¡POR FAVOR SELECIONE EL NÚMERO CORRECTO! ${plain}"
exit ;;
esac
