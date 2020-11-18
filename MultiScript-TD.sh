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
vmulti="${red}v1.0"
vpack="${red}v3.5k"
vssh="${red}v31"
vmx="${red}v8.1"
vadm="${red}v6.0"
vadmvps="${red}v1.6"
vdank="${red}v6.0"
vgold="${red}v6.0"
vpanel="${red}v25
vadmx="${red}v.5"
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
limpiar
#MULTISCRIPTS
vpsmx () {
sudo apt update -y; apt upgrade -y; wget https://raw.githubusercontent.com/ThonyDroidYT/VPS-Free/master/instalscript.sh; chmod 777 instalscript.sh; ./instalscript.sh
}
dankel2 () {
apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/ThonyDroidYT/ADM-MANAGER-DANKELTHAHER-FREE/master/instala.sh; chmod 777 instala.sh && ./instala.sh
}
dankel () {
apt-get update -y apt-get upgrade -y; wget https://raw.githubusercontent.com/ThonyDroidYT/ADM-MANAGER-DANKELTHAHER-FREE/master/Dankelthaher.sh; chmod 777 Dankelthaher.sh && ./Dankelthaher.sh
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
clear
echo -e "${barra}"
echo -e "${Rojo} ${cyan}       MULTISCRIPT FREE ${vmulti} ${green}[BY: @THONY_DROIDYT]      ${plain}"
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
