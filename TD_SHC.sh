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
Morado="\033[1;45m"
Morado2="\033[105m"
Celeste="\033[46m"
Verde="\033[102m"
Verdecaña="\033[42m"

#FUN IP
IP=$(wget -qO- ipv4.icanhazip.com)

#Version SHC
vshc="\033[1;31m3.8.9"
version="3.8.9"

#Actualizar Archivos
fun_update () {
apt-get update -y
apt-get upgrade -y
dpkg --configure -a
clear
}

#Install SHC
install_shc () {
clear
echo -e "${cyan}Descargando Archivos${plain}"
fun_bar 'fun_update'
apt-get install gcc -y
apt-get install make -y
wget http://www.datsi.fi.upm.es/~frosal/sources/shc-${version}.tgz
tar xvfz shc-${version}.tgz
rm -rf shc-${version}.tgz
cd shc-${version}
chmod 777 *
make
ln -s shc-${version}.c shc.c
sudo make install
echo -e "${green}Instalación Con Éxito!${plain}"
menu
}

#Inportar Script
import_script () {
clear
echo -e "${yellow}Importar Script Desde Un Link ${plain}"
echo -e "${cyan}Ingrese el Link del Script a Importar ${plain}"
read -p "LINK: 》" link
wget $link
chmod 777 *
fun_bar
echo -e "${green}Archivo Importado Con Éxito ${plain}"
}

#Encriptar Script
encript_script () {
clear
echo -e "${cyan} Encriptar Script ${plain}"
cd $HOME
cd shc-${version}
echo -e "${cyan}Ingrese el Nombre del Script a Encriptar ${plain}"
read -p "NOMBRE: 》" name
shc -v -f $HOME/shc-${version}/$name
cp $HOME/shc-${version}/$name.x /var/www/html/$name.x
fun_bar
echo -e "${green}Archivo ${red} $name.x ${green}Encriptado Correctamente!! ${plain}"
echo -e "${yellow}Ubicación del archivo.  $HOME/shc-${version}/$name.x ${plain}"
echo -e "${cyan}Archivo para Descargar Disponible en: ${green} $IP:81/$name.x ${plain}"
}

remover_script () {
clear
echo -e "${cyan}Remover SHC ${vshc} ${plain}"
cd $HOME
rm -rf shc-${version}
apt-get purge gcc -y
apt-get purge make -y
apt-get remove gcc -y
apt-get remove make -y
fun_bar
echo -e "${green}SHC ${vshc} ${green}Removido  con Éxito! ${plain}"
}

#MENU SCRIPT
menu () {
clear
echo -e "${barra}"
echo -e "${Morado} ${cyan}     TDSHC ENCRIPTADOR ${vshc} ${green}[BY: @THONY_DROIDYT]     ${plain}"
echo -e "${barra}"
echo -e "${num1} ${cyan}INSTALAR SHC ${vshc}  ${plain}"
echo -e "${num2} ${cyan}IMPORTAR SCRIPT ${plain}"
echo -e "${num3} ${cyan}ENCRIPTAR SCRIPT  ${plain}"
echo -e "${num4} ${cyan}REMOVER SHC ${vshc}  ${plain}"
#echo -e "${num5} ${cyan}FUNTION FIVE  ${plain}"
echo -e "${num0} ${red}SALIR DEL SCRIPT ${plain}"
echo -e "${barra}"
#echo -e "${blue}SELECIONE UNA OPCIÓN: 》 ${yellow}"; read script
read -p "SELECIONE UNA OPCIÓN: 》" script
case $script in
0)
clear
exit;;
1)install_shc;;
2)import_script;;
3)encript_script;;
4)remover_script;;
5)funtion_five;;
*)echo -e "${red}¡POR FAVOR SELECIONE EL NÚMERO CORRECTO! ${plain}"
menu;;
esac
}
menu
