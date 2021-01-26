#!/bin/bash
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
#tput cuu1
#tput dl1
done
echo -e " \033[1;33m[\033[1;31m####################\033[1;33m] - \033[1;32m100%\033[0m"
sleep 1s
}

#Install Trojan
trojanserver () {
echo -e "\033[1;33m Se instalará el servidor de Trojan\033[0m"
echo -e "\033[1;33m Si ya tenías una instalacion Previa, esta se eliminara\033[0m"
#echo -e "\033[1;33m Debes tener instalado previamente GO Lang\033[0m"
echo -e "\033[1;33m IMPORTANTE DEBES TENER LIBRES PUERTOS 80 / 443\033[0m"
echo -e "\033[1;33m Continuar?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
killall trojan
bash -c "$(wget -O- https://raw.githubusercontent.com/trojan-gfw/trojan-quickstart/master/trojan-quickstart.sh)"
clear
echo -e "Δ Generando Certificados SSL"
mkdir /etc/newadm/trojancert 1> /dev/null 2> /dev/null
curl -o /usr/local/etc/trojan/config.json https://raw.githubusercontent.com/powermx/dl/master/config.json 1> /dev/null 2> /dev/null
openssl genrsa 2048 > /etc/newadm/trojancert/trojan.key
chmod 400 /etc/newadm/trojancert/trojan.key
openssl req -new -x509 -nodes -sha256 -days 365 -key /etc/newadm/trojancert/trojan.key -out /etc/newadm/trojancert/trojan.crt
clear
echo -e "\033[1;37mΔ Generando Configuracion"
sed -i '13i        "cert":"/etc/newadm/trojancert/trojan.crt",' /usr/local/etc/trojan/config.json
sed -i '14i        "key":"/etc/newadm/trojancert/trojan.key",' /usr/local/etc/trojan/config.json
#figlet -p -f smslant < /root/name
#echo -e "\033[1;37m      【     ★ VPSPack v. $vpspackversion ★     】\033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m ───────────────────────────────────────\033[1;33m"
echo -e "\033[1;33mΔ Escriba el puerto de Trojan Server"
read -p ": " trojanport
sed -i 's/443/'$trojanport'/g' /usr/local/etc/trojan/config.json
echo -e "\033[1;33mΔ Escriba el password de Trojan Server"
read -p ": " trojanpass
sed -i 's/vpspack/'$trojanpass'/g' /usr/local/etc/trojan/config.json
echo -e "\033[1;32mΔ Iniciando Trojan Server"
fun_bar
screen -dmS trojanserv trojan /usr/local/etc/trojan/config.json
clear
#figlet -p -f smslant < /root/name
#echo -e "\033[1;37m      【     ★ VPSPack v. $vpspackversion ★     】\033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m ───────────────────────────────────────\033[1;33m"
fun_bar
echo -e "\033[1;33mTrojan Server Instalado"
echo -e "\033[1;33mEl puerto del servidor es: \033[1;32m $trojanport"
echo -e "\033[1;33mEl password del servidor es: \033[1;32m $trojanpass"
echo -e "\033[1;33mSi necesitas cambiar el password edita el archivo o Reinstala tu servidor"
echo -e "\033[1;32mRuta de Configuracion: /usr/local/etc/trojan/config.json"
cp /usr/local/etc/trojan/config.json /var/www/html/config.json
chmod 777 /var/www/html/*
echo -e "\033[1;32mArchivo Para Descarga Disponible en: \033[1;36mhttps://$(wget -qO- ipv4.icanhazip.com):81/config.json \033[0m"
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR\033[0m"
read -p " "
start_menu
fi
}

start_menu () {
echo -e "${barra}"
echo -e " ${cyan}       TROJAN SERVER ${green} [NEW-ADM-PLUS]    ${plain}"
echo -e "${barra}"
echo -e "${num1} ${cyan}INSTALAR TROJAN SERVER ${plain}"
echo -e "${num2} ${cyan}DESINTALAR TROJAN SERVER ${plain}"
echo -e "${num0} ${red}SALIR ${plain}"
read -p "SELECIONE UNA OPCIÓN: 》" trojan_menu
case $trojan_menu in
0)
clear
exit;;
1)trojanserver;;
2)removertrojan;;
*)echo -e "${red}¡POR FAVOR SELECIONE EL NÚMERO CORRECTO! ${plain}"
exit ;;
esac
}

function removertrojan () {
source <(curl -sL https://git.io/trojan-install) --remove
echo -e "\033[1;32m  Desinstalacion Completa \033[0m"
echo -e "\033[1;31m PRESIONE ENTER\033[0m"
read -p "Enter " enter
}
start_menu
