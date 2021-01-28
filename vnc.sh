#!/bin/bash
#BARRA AZUL
#barra="\033[1;34m======================================================\033[0m"
#barra="\033[1;34m**********************************************************\033[0m"
barra="\033[1;34m++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\033[0m"
#barra="\033[1;34m###############################################\033[0m"
#barra="\033[1;34m_____________________________________________________\033[0m"
IP=$(wget -qO- ipv4.icanhazip.com)
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
#FUN_BAR
fun_bar () {
comando="$1"
 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
echo -ne " \033[1;33m["
   for((i=0; i<10; i++)); do
   echo -ne "\033[1;31m##"
   sleep 0.2
   done
echo -ne "\033[1;33m]"
sleep 1s
echo
tput cuu1
tput dl1
done
echo -e " \033[1;33m[\033[1;31m####################\033[1;33m] - \033[1;32m100%\033[0m"
sleep 1s
}
#Actualizar Archivos
fun_update () {
apt-get update -y
apt-get upgrade -y
dpkg --configure -a
clear
}
configurarvnc () {
echo -e "\033[1;36mConfigurar VNC \033[0m"
fun_bar 'stopvnc'
mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
touch ~/.vnc/xstartup
echo -e "\033[1;33mConfigurando VNC\033[0m"
fun_bar
echo '#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &' >> ~/.vnc/xstartup
sudo chmod +x ~/.vnc/xstartup
fun_bar 'conectvnc'
echo -e "\033[1;32mVNC Configurado Correctamente! \033[0m"
}
vnc_ssh () {
echo -e "\033[1;32mConexión VNC Segura Con SSH\033[0m"
echo -e "\033[1;33mIngrese un nombre de usuario sudo no root \033[0m"
read -p "USUARIO: 》  " user
ssh -L 5901:127.0.0.1:5901 -C -N -l $user $IP
echo -e "\033[1;36mProcedimiento Completado\033[0m"
echo -e "\033[1;36mUtilice un cliente VNC para conectarse a  \033[1;32m$IP:5901\033[0m"
echo -e "\033[1;36mSe le pedirá que autentique usando la contraseña que configuró al instalar vnc.\033[0m"
}
installvnc () {
echo -e "${barra}"
echo -e "\033[1;36mLA INSTALACION PUEDE DEMORAR ALGUNOS MINUTOS\033[0m"
echo -e "${barra}"
echo -e "\033[1;36mRECUERDA QUE DEBES INSTALAR LA APLICACION\033[0m"
echo -e "\033[1;36mVNC VIEWER DESDE PLAYSTORE PARA USAR EL SERVIDOR VNC\033[0m"
fun_bar 'fun_update'
echo -e "\033[1;33mActualizando Paquetes\033[0m"
fun_bar
echo -e "\033[1;33mInstalando Paquetes Necesarios \033[0m"
fun_bar
sudo apt install xfce4 xfce4-goodies -y
sudo apt install tightvncserver -y
apt-get install firefox -y
apt-get install iceweasel
#apt-get install xfce4 xfce4-goodies gnome-icon-theme tightvncserver
clear
echo -e "\033[1;36mPaquetes Instalados \033[0m"
fun_bar
echo -e "\033[1;36mIniciando Servidor VNC \033[0m"
fun_bar
echo -e "\033[1;36mAhora Introduzca una contraseña para acceder a su máquina de forma remota\033[0m"
vncserver
#fun_bar
echo -e "${barra}"
echo -e "\033[1;36mServidor VNC Instalado Correctamente! \033[0m"
#echo -e "\033[1;36mRECUERDA QUE DEBES INSTALAR LA APLICACION\033[0m"
#echo -e "\033[1;36mVNC VIEWER DESDE PLAYSTORE PARA USAR EL SERVIDOR VNC\033[0m"
echo -e "\033[1;32mIP: \033[1;33m$IP  \033[0m"
echo -e "\033[1;32mPUERTO: \033[1;33m5901 \033[0m"
echo -e "\033[1;32mPASSWORD: \033[1;33mLA QUE PUSO ANTES\033[0m"
echo -e "${barra}"
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
#echo -e "${barra}"
echo -e "${cyan}        INSTALADOR VNC VIEWER   ${green}[NEW-ADM-PLUS] ${plain}"
echo -e "${barra}"
echo -e "\033[1;32m[1] \033[1;31m> \033[1;33mINSTALAR \033[1;36mVNC\033[0m"
echo -e "\033[1;32m[2] \033[1;31m> \033[1;32mCONFIGURAR \033[1;36mVNC\033[0m"
echo -e "\033[1;32m[3] \033[1;31m> \033[1;33mCONEXIÓN SEGURA DE \033[1;36mVNC \033[1;33mCON \033[1;32mSSH\033[0m"
echo -e "\033[1;32m[4] \033[1;31m> \033[1;32mCONECTAR \033[1;36mVNC\033[0m"
echo -e "\033[1;32m[5] \033[1;31m> \033[1;31mPARAR \033[1;36mVNC\033[0m"
echo -e "\033[1;32m[6] \033[1;31m> \033[1;31mREMOVER \033[1;36mVNC\033[0m"
echo -e "\033[1;32m[0] \033[1;31m> \033[1;31mSALIR\033[0m"
#echo -e "${barra}"
#echo -e "${blue}SELECIONE UNA OPCIÓN: 》 ${yellow}"; read multiscripts
read -p "SELECIONE UNA OPCIÓN: 》" vncviewer
case $vncviewer in
0)
clear
exit;;
1)installvnc;;
2)configurarvnc;;
3)vnc_ssh;;
4)conectvnc;;
5)stopvnc;;
6)removevnc;;
*)echo -e "${red}¡POR FAVOR SELECIONE EL NÚMERO CORRECTO! ${plain}"
exit ;;
esac
}
menuvnc
