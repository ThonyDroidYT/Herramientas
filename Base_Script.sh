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
num6='\033[1;32m [6] \033[1;31m>'
num7='\033[1;32m [7] \033[1;31m>'
num8='\033[1;32m [8] \033[1;31m>'
num9='\033[1;32m [9] \033[1;31m>'
num10='\033[1;32m [10] \033[1;31m>'
num11='\033[1;32m [11] \033[1;31m>'
num12='\033[1;32m [12] \033[1;31m>'
num13='\033[1;32m [13] \033[1;31m>'

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
#PROCESSADOR
_core=$(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)")
_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")

#SISTEMA
_system=$(printf '%-14s' "$system")
_ram=$(printf ' %-9s' "$(free -h | grep -i mem | awk {'print $2'})")
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")

#Fecha y Hora
_fecha=$(date +'%d/%m/%Y')
#_fecha=$(date +'%d:%m:%Y')
_hora=$(printf '%(%H:%M:%S)T')

#Date-Time
date () {
echo -e "${red}Fecha: ${blan}$_fecha                     ${red}Hora: ${blan}$_hora"
}

# MYIP
IP=$(wget -qO- ipv4.icanhazip.com)

os_system () {
system=$(echo $(cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/      //'))
echo $system|awk '{print $1, $2}'
}
#MEMORIA
memoria () {
echo -e "${barra}"
echo -e "\033[1;32mSISTEMA              MEMORIA RAM      PROCESADOR "
echo -e "\033[1;31mOS: \033[1;37m"$(os_system)"   \033[1;31mTotal:\033[1;37m$_ram \033[1;31mNucleos: \033[1;37m$_core\033[0m"
echo -e "\033[1;31mIP:\033[1;37m $IP   \033[1;31mEn uso: \033[1;37m$_usor \033[1;31mEn uso: \033[1;37m$_usop\033[0m"
}
#MEMORIA 2
memoria2 () {
echo -e "${barra}"
echo -e "\033[1;32mSISTEMA            MEMORIA RAM      PROCESADOR "
echo -e "\033[1;31mOS: \033[1;37m$_system  \033[1;31mTotal:\033[1;37m$_ram \033[1;31mNucleos: \033[1;37m$_core\033[0m"
echo -e "\033[1;31mIP:\033[1;37m$IP     \033[1;31mEn uso: \033[1;37m$_usor \033[1;31mEn uso: \033[1;37m$_usop\033[0m"
}
#Actualizar Archivos
fun_update () {
apt-get update -y
apt-get upgrade -y
dpkg --configure -a
clear
}


echo -e "${barra}"
echo -e "${Rojo} ${cyan}       MULTISCRIPT FREE ${vmulti} ${green}[BY: @THONY_DROIDYT]     ${plain}"
memoria
date
echo -e "${barra}"
echo -e "${num1} ${cyan}INSTALAR VPS-MX BY KALIX1  ${plain}"
echo -e "${num2} ${cyan}INTALAR NEW-ADM-DANKEL  ${plain}"
echo -e "${num3} ${cyan}INSTALAR VPSPACK BY POWERMX  ${plain}"
echo -e "${num4} ${cyan}INSTALAR SSHPLUS BY CRAZY_VPN  ${plain}"
echo -e "${num5} ${cyan}INSTALAR ADM-MANAGER OFICIAL FREE  ${plain}"
echo -e "${num6} ${cyan}INSTALAR GOLDEN-ADM-PRO BY DEADSHOOT  ${plain}"
echo -e "${num7} ${cyan}INSTALAR ADMVPS FREE  ${plain}"
echo -e "${num8} ${cyan}INSTALAR AMX-ADM BY ANDROIDMX-TEAM  ${plain}"
echo -e "${num9} ${cyan}INSTALAR ADM-MANAGER-ALPHA BY THONYDROID  ${plain}"
echo -e "${barra}"
echo -e "${num10} ${cyan}INSTALAR PANELWEB SSHPLUS BY CRAZY_VPN  ${plain}"
echo -e "${num11} ${cyan}VER CAMBIOS ${green}MULTISCRIPT ${plain}"
echo -e "${barra}"
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
6)golden;;
7)admvps;;
8)amxadm;;
9)adm-alpha;;
10)panelweb;;
11)changelog;;
*)echo -e "${red}¡POR FAVOR SELECIONE EL NÚMERO CORRECTO! ${plain}"
exit ;;
esac
