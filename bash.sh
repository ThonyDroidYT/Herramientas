#!/bin/bash
#BARRAS AZUL
#barra="\033[1;34m======================================================\033[0m"
#barra="\033[1;34m**********************************************************\033[0m"
barra="\033[1;34m+++++++++++++++++++++++++++++++++++++++++++++++++++++++\033[0m"
#barra="\033[1;34m###############################################\033[0m"
#barra="\033[1;34m_____________________________________________________\033[0m"

#FUN Progreso
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

#NUMEROS
num0='\033[1;32m [0] \033[1;31m>'
num1='\033[1;32m [1] \033[1;31m>'
num11='\033[1;32m [11] \033[1;31m>'
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

install_bashofs () {
echo -e "${cyan}Encriptar Script Bash ${plain}"
fun_update
apt-get install python2
apt-get install git
apt-get install nodejs
npm install -g bash-obfuscate
clear
fun_bar
cd $HOME
git clone https://github.com/Syhrularv/obfuscate.git
cd obfuscate
}

install_bashofs_termux () {
echo -e "${cyan}Encriptar Script Bash ${plain}"
pkg update -y; pkg upgrade -y
pkg install python2 -y
pkg install git -y
pkg install install nodejs -y
npm install -g bash-obfuscate -y
clear
fun_bar
cd $HOME
git clone https://github.com/Syhrularv/obfuscate.git
cd obfuscate
}

#INICiAR BASH-OBFUSCATE
start_bashofs () {
clear
cd $HOME/obfuscate
python2 bash.py
}

#REMOVE BASH-OBFUSCATE
remove_bashofs () {
echo -e "${cyan}Remover Bash-Obfuscate ${plain}"
cd $HOME
rm -rf obfuscate
apt-get purge nodejs
-y
apt-get remove nodejs
-y
apt-get purge -g bash-obfuscate
apt-get remove -g bash-obfuscate
echo -e "${green}Bash-Obfuscate Removido Con Éxito!!${plain}"
}

# IMPORT
import_bashofs () {
clear
cd $HOME/obfuscate
echo -e "${yellow}Importar Script Desde Un Link ${plain}"
echo -e "${cyan}Ingrese el Link del Script a Importar ${plain}"
read -p "LINK: 》" link
wget $link
chmod 777 *
fun_bar
echo -e "${green}Archivo Importado Con Éxito ${plain}"
}

# IMPORT
move_bashofs () {
clear
echo -e "${cyan}MOVER ARCHIVO DE $HOME AL DIRECTORIO DE TRABAJO${plain}"
cd $HOME
echo -e "${yellow}Ingrese el Nombre del Archivo a Mover ${plain}"
read -p "NOMBRE: 》" namex
echo -e "${cyan}Ingrese el Nombre para el Archivo Movido ${plain}"
read -p "NOMBRE: 》" nam3
cp -i $namex $HOME/obfuscate/$nam3
clear
fun_bar
echo -e "${green}Archivo ${red}$namex ${green}Movido a $HOME/obfuscate/$nam3 con Éxito! ${plain}"
menu
}

#MENU SCRIPT
menu () {
clear
echo -e "${barra}"
echo -e "${Rojo} ${cyan}      BASH-OBFUSCATE SCRIPT  ${green}[BY: @THONY_DROIDYT]     ${plain}"
echo -e "${barra}"
echo -e "${num1} ${cyan}INSTALAR BASH-OBFUSCATE UBUNTU ${plain}"
echo -e "${num11} ${cyan}INSTALAR BASH-OBFUSCATE TERMUX ${plain}"
echo -e "${num2} ${cyan}ENCRIPTAR SCRIPT ${plain}"
echo -e "${num3} ${cyan}REMOVER BASH-OBFUSCATE ${plain}"
echo -e "${num3} ${cyan}IMPORTAR SCRIPT ${plain}"
echo -e "${num5} ${cyan}MOVER SCRIPT AL DIRECTORIO DE TRABAJO ${plain}"
echo -e "${num0} ${red}SALIR DEL SCRIPT ${plain}"
echo -e "${barra}"
#echo -e "${blue}SELECIONE UNA OPCIÓN: 》 ${yellow}"; read script
read -p "SELECIONE UNA OPCIÓN: 》" script
case $script in
0)
clear
exit;;
1)install_bashofs;;
11)install_bashofs_termux;;
2)start_bashofs;;
3)remove_bashofs;;
4)import_bashofs;;
5)move_bashofs;;
*)echo -e "${red}¡POR FAVOR SELECIONE EL NÚMERO CORRECTO! ${plain}"
exit ;;
esac
}
menu
