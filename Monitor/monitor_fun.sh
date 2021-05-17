#!/bin/bash
SCPdir="/etc/newadm"
SCPidioma="${SCPdir}/idioma"
#Fun_trans
IP=$(wget -qO- ipv4.icanhazip.com)
fun_trans () { 
local texto
local retorno
declare -A texto
[[ ! -e ${SCPidioma} ]] && touch ${SCPidioma}
local LINGUAGE=$(cat ${SCPidioma})
[[ -z $LINGUAGE ]] && LINGUAGE=es
[[ $LINGUAGE = "es" ]] && echo "$@" && return
[[ ! -e /usr/bin/trans ]] && wget -O /usr/bin/trans https://git.io/trans &> /dev/null
[[ ! -e /etc/texto-adm ]] && touch /etc/texto-adm
source /etc/texto-adm
if [[ -z "$(echo ${texto[$@]})" ]]; then
#ENGINES=(aspell google deepl bing spell hunspell apertium yandex)
#NUM="$(($RANDOM%${#ENGINES[@]}))"
retorno="$(source trans -e bing -b es:${LINGUAGE} "$@"|sed -e 's/[^a-z0-9 -]//ig' 2>/dev/null)"
echo "texto[$@]='$retorno'"  >> /etc/texto-adm
echo "$retorno"
else
echo "${texto[$@]}"
fi
}
#MONITOR DE SERVICIOS
preparar () {
echo -e "\033[1;32m$(fun_trans "Descargando Archivos Necesarios")\033[0m"
#apt-get install screen -y
#clear
#MONITOR.SH
[[ ! -e /bin/monitor.sh ]] && wget -O /bin/monitor.sh https://raw.githubusercontent.com/ThonyDroidYT/Herramientas/main/Monitor/monitor.sh &> /dev/null && chmod 777 /bin/monitor.sh
#ESTILOS.CSS
[[ ! -e /var/www/html/estilos.css ]] && wget -O /var/www/html/estilos.css https://raw.githubusercontent.com/ThonyDroidYT/Herramientas/main/Monitor/estilos.css &> /dev/null && chmod 777 /var/www/html/estilos.css
[[ ! -e /bin/resetsshdrop ]] && wget -O /bin/resetsshdrop https://raw.githubusercontent.com/ThonyDroidYT/Herramientas/main/Monitor/resetsshdrop &> /dev/null && chmod 777 /bin/resetsshdrop
# FIN MONITOR.sh
clear
monservi_fun
}
#MONITOR DE SERVICIOS
monservi_fun () {
clear
monssh () {
sed -i "57d" /bin/monitor.sh
sed -i '57i EstadoServicio ssh' /bin/monitor.sh
}
mondropbear () {
sed -i "59d" /bin/monitor.sh
sed -i '59i EstadoServicio dropbear' /bin/monitor.sh
}
monssl() {
sed -i "61d" /bin/monitor.sh
sed -i '61i EstadoServicio stunnel4' /bin/monitor.sh
}
monsquid() {
sed -i "63d" /bin/monitor.sh
sed -i '63i [[ $(EstadoServicio squid) ]] && EstadoServicio squid3' /bin/monitor.sh
}
monapache() {
sed -i "65d" /bin/monitor.sh
sed -i '65i EstadoServicio apache2' /bin/monitor.sh
}
msg -bar
echo -e "\033[44m        =====>>►►   NEW ULTIMATE PLUS   ◄◄<<=====        \033[1;37m"
msg -bar
echo -e "\033[1;32m          $(fun_trans "MONITOR DE SERVICIOS PRINCIPALES")"

PIDVRF3="$(ps aux|grep "${SCPdir}/monitor.sh monitorservi"|grep -v grep|awk '{print $2}')"

PIDVRF5="$(ps aux|grep "${SCPdir}/monitor.sh moni2"|grep -v grep|awk '{print $2}')"

if [[ -z $PIDVRF3 ]]; then
sed -i '5a\screen -dmS very3 ${SCPdir}/monitor.sh monitorservi' /bin/resetsshdrop
msg -bar
echo -e "\033[1;34m          ¿$(fun_trans "Monitorear Protocolo") SSH/SSHD?"
msg -bar
read -p "                    [ s | n ]: " monssh  
sed -i "57d" /bin/monitor.sh
sed -i '57i #EstadoServicio ssh' /bin/monitor.sh 
[[ "$monssh" = "s" || "$monssh" = "S" ]] && monssh
msg -bar
echo -e "\033[1;34m          ¿$(fun_trans "Monitorear Protocolo DROPBEAR")?"
msg -bar
read -p "                    [ s | n ]: " mondropbear  
sed -i "59d" /bin/monitor.sh
sed -i '59i #EstadoServicio dropbear' /bin/monitor.sh
[[ "$mondropbear" = "s" || "$mondropbear" = "S" ]] && mondropbear
msg -bar
echo -e "\033[1;34m            ¿$(fun_trans "Monitorear Protocolo SSL")?"
msg -bar
read -p "                    [ s | n ]: " monssl  
sed -i "61d" /bin/monitor.sh
sed -i '61i #EstadoServicio stunnel4' /bin/monitor.sh
[[ "$monssl" = "s" || "$monssl" = "S" ]] && monssl
msg -bar
echo -e "\033[1;34m            ¿$(fun_trans "Monitorear Protocolo SQUID")?"
msg -bar
read -p "                    [ s | n ]: " monsquid  
sed -i "63d" /bin/monitor.sh
sed -i '63i #[[ $(EstadoServicio squid) ]] && EstadoServicio squid3' /bin/monitor.sh
[[ "$monsquid" = "s" || "$monsquid" = "S" ]] && monsquid
msg -bar
echo -e "\033[1;34m            ¿$(fun_trans "Monitorear Protocolo APACHE")?"
msg -bar
read -p "                    [ s | n ]: " monapache  
sed -i "65d" /bin/monitor.sh
sed -i '65i #EstadoServicio apache2' /bin/monitor.sh
[[ "$monapache" = "s" || "$monapache" = "S" ]] && monapache



#echo "screen -dmS very3 ${SCPdir}/monitor.sh monitorservi" >> /bin/resetsshdrop
cd ${SCPdir}
screen -dmS very3 ${SCPdir}/monitor.sh monitorservi
screen -dmS monis2 ${SCPdir}/monitor.sh moni2
else


for pid in $(echo $PIDVRF3); do
kill -9 $pid &>/dev/null
sed -i "6d" /bin/resetsshdrop
done

for pid in $(echo $PIDVRF5); do
kill -9 $pid &>/dev/null
done


fi
msg -bar
echo -e "             $(fun_trans "Puedes Monitorear desde"):\n       \033[1;32m http://$IP:81/monitor.html"
msg -bar
[[ -z ${VERY3} ]] && monitorservi="\033[1;32m $(fun_trans "ACTIVADO") " || monitorservi="\033[1;31m $(fun_trans "DESACTIVADO") "
echo -e "            $monitorservi  --  $(fun_trans "CON EXITO")"
msg -bar

}
#TIMER MONITOR
monitor_auto () {
while true; do
monitor.sh 2>/dev/null
sleep 120s 
    done
}
if [[ "$1" = "monitorservi" ]]; then
monitor_auto
exit
fi
#RESET PYDIREC
pid_kill () {
[[ -z $1 ]] && refurn 1
pids="$@"
for pid in $(echo $pids); do
kill -9 $pid &>/dev/null
done
}
monitorport_fun () {
while true; do
pidproxy3=$(ps x | grep "PDirect.py" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy3 ]] && pid_kill $pidproxy3
sleep 6h 
done
}
if [[ "$1" = "moni2" ]]; then
monitorport_fun
exit
fi
preparar
