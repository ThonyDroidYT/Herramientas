#!/bin/bash
#BARRA AZUL
#barra="\033[1;34m======================================================\033[0m"
#barra="\033[1;34m**********************************************************\033[0m"
barra="\033[1;34m+++++++++++++++++++++++++++++++++++++++++++++++++++++++\033[0m"
#barra="\033[1;34m###############################################\033[0m"
#barra="\033[1;34m_____________________________________________________\033[0m"
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
installvnc () {
echo -e "${barra}"
echo -e "\033[1;36mLA INSTALACION PUEDE DEMORAR ALGUNOS MINUTOS\033[0m"
echo -e "${barra}"
echo -e "\033[1;36mRECUERDA QUE DEBES INSTALAR LA APLICACION\033[0m"
echo -e "\033[1;36mVNC VIEWER DESDE PLAYSTORE PARA USAR EL SERVIDOR VNC\033[0m"
fun_update
echo -e "\033[1;33mActualizando Paquetes\033[0m"
#fun_bar
echo -e "\033[1;33mInstalando Paquetes Necesarios \033[0m"
#fun_bar
sudo apt install xfce4 xfce4-goodies -y
sudo apt install tightvncserver -y
apt-get install firefox -y
apt-get install iceweasel
#apt-get install xfce4 xfce4-goodies gnome-icon-theme tightvncserver
clear
#fun_bar
echo -e "\033[1;36mPaquetes Instalados \033[0m"
#fun_bar
echo -e "\033[1;36mIniciando Servidor VNC \033[0m"
#fun_bar
echo -e "\033[1;36mAhora Introduzca una contraseña para acceder a su máquina de forma remota\033[0m"
vncserver
clear
#fun_bar
echo -e "\033[1;36mServidor VNC Instalado Correctamente! \033[0m"
#echo -e "\033[1;36mRECUERDA QUE DEBES INSTALAR LA APLICACION\033[0m"
#echo -e "\033[1;36mVNC VIEWER DESDE PLAYSTORE PARA USAR EL SERVIDOR VNC\033[0m"
echo -e "\033[1;32mIP: \033[1;37m$IP  \033[0m"
echo -e "\033[1;32mPUERTO: \033[1;37m5901 \033[0m"
echo -e "\033[1;32mPASSWORD: \033[1;37mLA QUE PUSO ANTES\033[0m"
}
removevnc () {
echo -e "\033[1;31mRemoviendo Servidor VNC  \033[0m"
apt-get remove xfce4 xfce4-goodies gnome-icon-theme tightvncserver -y
apt-get remove iceweasel -y
apt-get remove firefox -y
#fun_bar
echo -e "\033[1;32mRemovido con Éxito! \033[0m"
}
conectvnc () {
vncserver
}
stopvnc () {
echo -e "\033[1;32mParando Servidor VNC  \033[0m"
vncserver -kill :1
vncserver -kill :2
vncserver -kill :3
#fun_bar
echo -e "\033[1;32mVNC Parado con Éxito! \033[0m"
}
menuvnc () {
IP=$(wget -qO- ipv4.icanhazip.com)
echo -e "${barra}"
echo -e "${cyan}        INSTALADOR VNC VIEWER   ${green}[NEW-ADM-PLUS] ${plain}"
echo -e "${barra}"
echo -e "\033[1;31m[0] \033[1;31m> \033[1;31m SALIR\033[0m"
echo -e "\033[1;32m[1] \033[1;31m> \033[1;36mINSTALAR VNC\033[0m"
echo -e "\033[1;32m[2] \033[1;31m> \033[0;32mCONECTAR \033[1;36mVNC\033[0m"
echo -e "\033[1;32m[3] \033[1;31m> \033[1;31mPARAR\033[1;36m VNC\033[0m"
echo -e "\033[1;32m[4] \033[1;31m> \033[1;37mREMOVER \033[1;36mVNC\033[0m"
echo -e "${barra}"
#echo -e "${blue}SELECIONE UNA OPCIÓN: 》 ${yellow}"; read multiscripts
read -p "SELECIONE UNA OPCIÓN: 》" vncviewer
case $vncviewer in
0)
clear
exit;;
1)installvnc;;
2)removevnc;;
3)conectvnc;;
4)stopvnc;;
*)echo -e "${red}¡POR FAVOR SELECIONE EL NÚMERO CORRECTO! ${plain}"
exit ;;
esac
}
menuvnc
