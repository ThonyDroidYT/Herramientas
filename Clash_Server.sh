#!/bin/bash
clashserver(){
echo -e "\033[1;33m Se instalará el servidor de \033[1;32mClash\033[0m"
#echo -e "\033[1;33m Debes tener instalado previamente \033[1;32mGO Lang\033[0m"
echo -e "\033[1;33m Debes tener instalado previamente \033[1;32mTrojan Server\033[0m"
echo -e "\033[1;33m IMPORTANTE DEBES TENER LIBRES PUERTOS \033[1;32m7890 / 7891 / 7892 / 9090\033[0m"
echo -e "\033[1;33m Continuar?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
killall clash 1> /dev/null 2> /dev/null
echo -e "Δ Instalando Servidor Clash"
go get -u -v github.com/Dreamacro/clash 1> /dev/null 2> /dev/null
clear
echo -e "Δ Creando Directorios y Archivos"
mkdir /root/.config 1> /dev/null 2> /dev/null
mkdir /root/.config/clash 1> /dev/null 2> /dev/null
curl -o /root/.config/clash/config.yaml https://raw.githubusercontent.com/kirrathmx/dl/master/c.yaml 1> /dev/null 2> /dev/null
clear
#figlet -p -f smslant < /root/name
#echo -e "\033[1;37m      【     ★ VPSPack v. $vpspackversion ★     】\033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m ───────────────────────────────────────\033[1;33m"
echo -e "\033[1;33mΔ Escriba el puerto de Trojan Server"
read -p ": " troport
sed -i "s/puertodelservidor/$troport/g" /root/.config/clash/config.yaml
sed -i "s/ipdelservidor/$ip/g" /root/.config/clash/config.yaml
echo -e "\033[1;33mΔ Escriba el password de Trojan Server"
read -p ": " tropass
sed -i "s/clavedelservidor/$tropass/g" /root/.config/clash/config.yaml
echo -e "\033[1;33mΔ Escriba el SNI de su metodo"
read -p ": " trosni
sed -i "s/snidelmetodo/$trosni/g" /root/.config/clash/config.yaml
echo -e "Δ Iniciando Servidor"
screen -dmS clashse clash
cp /root/.config/clash/config.yaml /var/www/html/clash.yaml
clear
#figlet -p -f smslant < /root/name
#echo -e "\033[1;37m      【     ★ VPSPack v. $vpspackversion ★     】\033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m ───────────────────────────────────────\033[1;33m"
echo -e "\033[1;33mClash Server Instalado"
echo -e "\033[1;32mRuta de Configuracion: /root/.config/clash/config.yaml"
echo -e "\033[1;32mRuta de archivo de importacion de servidor Clash: http://$(wget -qO- ipv4.icanhazip.com):81/clash.yaml"
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR\033[0m"
read -p " "
#vpspack
fi
}
clashserver
