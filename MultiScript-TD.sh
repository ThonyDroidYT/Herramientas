#!/bin/bash
#BARRA AZUL
#barra="\033[1;34m======================================================\033[0m"
#barra="\033[1;34m**********************************************************\033[0m"
barra="\033[1;34m+++++++++++++++++++++++++++++++++++++++++++++++++++++++\033[0m"
#barra="\033[1;34m###############################################\033[0m"
#barra="\033[1;34m_____________________________________________________\033[0m"
#FUNCION LIMPIAR
limpiar () {
rm -rf MultiScript-TD.sh
rm -rf MultiScript-TD.sh.1
#rm -rf MultiScript-TD.sh.2
rm -rf instala.sh
rm -rf instala.sh.1
#rm -rf instala.sh.2
rm -rf instalar.sh
rm -rf instalar.sh.1
#rm -rf instalar.sh.2
rm -rf instalador
rm -rf instalador.1
#rm -rf instalador.2
rm -rf goldenvps.sh
rm -rf goldenvps.sh.1
#rm -rf goldenvps.sh.2
rm -rf instalscript.sh
rm -rf instalscripr.sh.1
#rm -rf instalscript.sh.2
rm -rf Dankelthaher.sh
rm -rf Dankelthaher.sh.1
#rm -rf Dankelthaher.sh.2
rm -rf Plus
rm -rf Plus.1
#rm -rf Plus.2
rm -rf admsetup.sh
rm -rf admsetup.sh.1
#rm -rf admsetup.sh.2
rm -rf Panelweb.sh
rm -rf Panelweb.sh.1
#rm -rf Panelweb.sh.2
clear
}
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
#VERSIONES
vmulti="\033[1;33mv1.0"
vpack="\033[1;31mv3.5k"
vssh="\033[1;31mv31"
vmx="\033[1;31mv8.1"
vadm="\033[1;31mv6.0"
vadmvps="\033[1;31mv1.6"
vdank="\033[1;31mv6.0"
vgold="\033[1;31mv6.0"
vpanel="\033[1;31mv25"
vadmx="\033[1;31mv5.0"
#COLORES
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

# MYIP
IP=$(wget -qO- ipv4.icanhazip.com)

os_system () {
system=$(echo $(cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/      //'))
echo $system|awk '{print $1, $2}'
}
#MEMORIA
memoria () {
echo -e "${barra}"
echo -e "\033[1;32mSISTEMA            MEMORIA RAM      PROCESADOR "
echo -e "\033[1;31mOS: \033[1;37m"$(os_system)"  \033[1;31mTotal:\033[1;37m$_ram \033[1;31mNucleos: \033[1;37m$_core\033[0m"
echo -e "\033[1;31mIP:\033[1;37m $IP     \033[1;31mEn uso: \033[1;37m$_usor \033[1;31mEn uso: \033[1;37m$_usop\033[0m"
}
#MEMORIA 2
memoria2 () {
echo -e "${barra}"
echo -e "\033[1;32mSISTEMA            MEMORIA RAM      PROCESADOR "
echo -e "\033[1;31mOS: \033[1;37m$_system  \033[1;31mTotal:\033[1;37m$_ram \033[1;31mNucleos: \033[1;37m$_core\033[0m"
echo -e "\033[1;31mIP:\033[1;37m$IP     \033[1;31mEn uso: \033[1;37m$_usor \033[1;31mEn uso: \033[1;37m$_usop\033[0m"
}
#MULTISCRIPTS
vpsmx () {
sudo apt update -y; apt upgrade -y; wget https://raw.githubusercontent.com/ThonyDroidYT/VPS-Free/master/instalscript.sh; chmod 777 instalscript.sh; ./instalscript.sh
}
dankel2 () {
apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/ThonyDroidYT/ADM-MANAGER-DANKELTHAHER-FREE/master/instala.sh; chmod 777 instala.sh && ./instala.sh
}
dankel () {
apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/ThonyDroidYT/ADM-MANAGER-DANKELTHAHER-FREE/master/Dankelthaher.sh; chmod 777 Dankelthaher.sh && ./Dankelthaher.sh
}
vpspack () {
apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/ThonyDroidYT/VPS-Pack-3.7.2/main/instalador; chmod 777 instalador; ./instalador
}
sshplus () {
apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Plus; chmod 777 Plus; ./Plus
}
admoff () {
apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/ThonyDroidYT/Herramientas/main/instalar.sh; chmod 777 instalar.sh; ./instalar.sh; wget -O /etc/newadm/message.txt https://raw.githubusercontent.com/ThonyDroidYT/Herramientas/main/Creditosxd.txt
}
golden () {
apt-get update -y; apt-get upgrade -y; wget -O $HOME/goldenvps.sh https://raw.githubusercontent.com/ThonyDroidYT/GOLDEN-ADM-MANAGER/master/goldenvps_v2.sh; chmod 777 goldenvps.sh && ./goldenvps.sh
}
admvps () {
apt-get update -y; apt-get upgrade -y; wget -O $HOME/admsetup.sh https://www.dropbox.com/s/0s70rsg7cg2b77k/admsetup.sh?dl=0; chmod 777 admsetup.sh; ./admsetup.sh
}
amxadm () {
apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/powermx/AMXADM/master/instala.sh && bash instala.sh
}
panelweb () {
apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/Panelweb.sh; chmod +x Panelweb.sh; ./Panelweb.sh
}
#MENU
limpiar
clear
echo -e "${barra}"
memoria2
echo -e "${Rojo} ${cyan}       MULTISCRIPT FREE ${vmulti} ${green}[BY: @THONY_DROIDYT]     ${plain}"
echo -e "${barra}"
echo -e "${num1} ${cyan}INSTALAR VPS-MX BY KALIX1 ${vmx} ${plain}"
echo -e "${num2} ${cyan}INTALAR NEW-ADM-DANKEL ${vdank} ${plain}"
echo -e "${num3} ${cyan}INSTALAR VPSPACK BY POWERMX ${vpack} ${plain}"
echo -e "${num4} ${cyan}INSTALAR SSHPLUS BY CRAZY_VPN ${vssh} ${plain}"
echo -e "${num5} ${cyan}INSTALAR ADM-MANAGER OFICIAL FREE ${vadm} ${plain}"
echo -e "${num6} ${cyan}INSTALAR GOLDEN-ADM-PRO BY DEADSHOOT ${vgold} ${plain}"
echo -e "${num7} ${cyan}INSTALAR ADMVPS FREE ${vadmvps} ${plain}"
echo -e "${num8} ${cyan}INSTALAR AMX-ADM BY ANDROIDMX-TEAM ${vadmx} ${plain}"
echo -e "${num9} ${cyan}INSTALAR PANELWEB SSHPLUS BY CRAZY_VPN ${vpanel} ${plain}"
echo -e "${num0} ${red}SALIR DEL MULTISCRIPT ${plain}"
echo -e "${barra}"
#echo -e "${blue}SELECIONE UNA OPCIÓN: 》 ${yellow}"; read multiscripts
read -p "SELECIONE UNA OPCIÓN: 》" multiscripts
case $multiscripts in
0)exit;;
1)vpsmx;;
2)dankel;;
3)vpspack;;
4)sshplus;;
5)admoff;;
6)golden;;
7)admvps;;
8)amxadm;;
9)panelweb;;
*)echo -e "${red}¡POR FAVOR SELECIONE EL NÚMERO CORRECTO! ${plain}"
exit ;;
esac
