#!/bin/bash
barra="\033[1;34m=========================================================\033[0m"
Block="/etc/bin" && [[ ! -d ${Block} ]] && exit
Block > /dev/null 2>&1
AIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
if [[ "$AIP" = "" ]]; then
AIP=$(wget -4qO- "http://whatismyip.akamai.com/")
fi
if [[ "$AIP" = "" ]]; then
AIP="192.168.0.1"
fi
while true; do
clear
if [ -e /etc/adm/bnr ]; then
/etc/adm/bnr
fi
#cowsay -f eyes "esta herramienta crea un panel de tu O.S para usarlo como ordenador...." | lolcat 
#figlet ADM-Plus | lolcat
echo -e "${barra}"
echo -e "\033[1;36mLA INSTALACION PUEDE DEMORAR ALGUNOS MINUTOS\033[0m"
echo -e "${barra}"
echo -e "\033[1;36mRECUERDA QUE DEVES DESCARGAR E INSTALAR LA APLICACION\033[0m"
echo -e "\033[1;36m DE VNC VIWER DESDE PLAYSTORE\033[0m"
echo -e "${barra}"
echo -e "\033[1;31m[0] \033[1;31m> \033[1;31m SALIR\033[0m"
echo -e "${barra}"
echo -e "\033[1;32m[1] \033[1;31m> \033[1;36mINSTALAR VNC\033[0m"
if [ -d  /root/.vnc/ ];then
vnc=$(ls /root/.vnc/ | grep :1.pid)
else
vnc=""
fi
if [ "$vnc" = "" ]; then
echo -e "\033[1;32m[2] \033[1;31m> \033[0;32mCONECTAR \033[1;36mVNC\033[0m"
else
echo -e "\033[1;32m[2] \033[1;31m> \033[1;31mPARAR\033[1;36m VNC\033[0m"
fi
echo -e "\033[1;32m[3] \033[1;31m> \033[1;37mREMOVER \033[1;36mVNC\033[0m"
echo -e "${barra}"
read -p "OPCION: 》" resposta
case $resposta in
1)
break
;;
2)
break
;;
3)
break
;;
0)
break
exit
;;
*)
clear
;;
esac
done


if [[ "$resposta" = '1' ]]; then
echo -e "\033[1;33m"
sleep 1s
apt-get install xfce4 xfce4-goodies gnome-icon-theme tightvncserver
sleep 1s
apt-get install iceweasel
sleep 1s
echo -e "\033[1;33m ESCOJA UNA CONTRASEÑA y DESPUÉS CONFIRMA\033[1;32m"
sleep 3s
vncserver
echo -e "\033[1;33m"
apt-get install firefox -y
echo -e "\033[1;36m VNC se conecta usando la ip de su vps en puerto 5901\033[1;32m"
echo -e "\033[1;36m Ejemplo: $AIP:5901\033[1;32m"
echo -e "\033[1;36m Para aceder a interfaz gráfica\033[1;32m"
echo -e "\033[1;36m Descargue de PLAYSTORE la app de VNC VIEWER\033[1;32m"
echo -e "\033[1;36m Coloque su IP $AIP y su puerto 5901\033[0m"
read -p "enter"
/bin/VNC
fi

if [[ "$resposta" = '2' ]]; then
if [ "$vnc" = "" ]; then
vncserver
else
vncserver -kill :1
fi
/bin/VNC
fi

if [[ "$resposta" = '3' ]]; then
apt-get remove xfce4 xfce4-goodies gnome-icon-theme tightvncserver -y
apt-get remove iceweasel -y
apt-get remove firefox -y
vncserver -kill :1
vncserver -kill :2
vncserver -kill :3
/bin/VNC
fi