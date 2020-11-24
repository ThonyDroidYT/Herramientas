#!/bin/bash

# Directorio destino
DIR=/var/www/html

# Nombre de archivo HTML a generar
ARCHIVO=monitor.html

# Fecha actual
FECHA=$(date +'%d/%m/%Y %H:%M:%S')

# Declaración de la función
EstadoServicio() {

    systemctl --quiet is-active $1
    if [ $? -eq 0 ]; then
        echo "<p>Estado del servicio $1 está || <span class='encendido'> ACTIVO</span>.</p>" >> $DIR/$ARCHIVO
    else
        echo "<p>Estado del servicio $1 está || <span class='detenido'> DESACTIVADO | REINICIANDO</span>.</p>" >> $DIR/$ARCHIVO
		service $1 restart &
NOM=`less /etc/newadm/ger-user/nombre.log` > /dev/null 2>&1
NOM1=`echo $NOM` > /dev/null 2>&1
IDB=`less /etc/newadm/ger-user/IDT.log` > /dev/null 2>&1
IDB1=`echo $IDB` > /dev/null 2>&1
KEY="862633455:AAGJ9BBJanzV6yYwLSemNAZAVwn7EyjrtcY"
URL="https://api.telegram.org/bot$KEY/sendMessage"
MSG="⚠️ AVISO DE VPS: $NOM1 ⚠️
❗️Protocolo $1 con fallo / Reiniciando❗️"
curl -s --max-time 10 -d "chat_id=$IDB1&disable_web_page_preview=1&text=$MSG" $URL
		
    fi
}

# Comienzo de la generación del archivo HTML
# Esta primera parte constitute el esqueleto básico del mismo.
echo "
<!DOCTYPE html>
<html lang='en'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
  <meta http-equiv='X-UA-Compatible' content='ie=edge'>
  <title>Monitor de Servicios ADM-PLUS</title>
  <link rel='stylesheet' href='estilos.css'>
</head>
<body>
<h1>Monitor de Servicios By Thony_DroidYT</h1>
<h2>Creditos: @Kalix1</h2>
<p id='ultact'>Última actualización: $FECHA</p>
<hr>
" > $DIR/$ARCHIVO




# Servicios a chequear (podemos agregar todos los que deseemos
# PROTOCOLO SSH
EstadoServicio ssh
# PROTOCOLO DROPBEAR
EstadoServicio dropbear
# PROTOCOLO SSL
EstadoServicio stunnel4
# PROTOCOLOSQUID
[[ $(EstadoServicio squid) ]] && EstadoServicio squid3
# PROTOCOLO APACHE
EstadoServicio apache2
on="<span class='encendido'> ACTIVO " && off="<span class='detenido'> DESACTIVADO | REINICIANDO "
[[ $(ps x | grep badvpn | grep -v grep | awk '{print $1}') ]] && badvpn=$on || badvpn=$off
echo "<p>Estado del servicio badvpn está ||  $badvpn </span>.</p> " >> $DIR/$ARCHIVO

#SERVICE BADVPN
PIDVRF3="$(ps aux|grep badvpn |grep -v grep|awk '{print $2}')"
if [[ -z $PIDVRF3 ]]; then
screen -dmS badvpn2 /bin/badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10
NOM=`less /etc/newadm/ger-user/nombre.log` > /dev/null 2>&1
NOM1=`echo $NOM` > /dev/null 2>&1
IDB=`less /etc/newadm/ger-user/IDT.log` > /dev/null 2>&1
IDB1=`echo $IDB` > /dev/null 2>&1
KEY="862633455:AAGJ9BBJanzV6yYwLSemNAZAVwn7EyjrtcY"
URL="https://api.telegram.org/bot$KEY/sendMessage"
MSG="⚠️ AVISO DE VPS: $NOM1 ⚠️
❗️ Reiniciando BadVPN ❗️"
curl -s --max-time 10 -d "chat_id=$IDB1&disable_web_page_preview=1&text=$MSG" $URL
else
for pid in $(echo $PIDVRF3); do
echo""
done
fi

#FUN TRANS
fun_trans () { 
local texto
local retorno
declare -A texto
SCPidioma="${SCPdir}/idioma"
[[ ! -e ${SCPidioma} ]] && touch ${SCPidioma}
local LINGUAGE=$(cat ${SCPidioma})
[[ -z $LINGUAGE ]] && LINGUAGE=es
[[ $LINGUAGE = "es" ]] && echo "$@" && return
[[ ! -e /usr/bin/trans ]] && wget -O /usr/bin/trans https://www.dropbox.com/s/l6iqf5xjtjmpdx5/trans?dl=0 &> /dev/null
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

#Sistema de Puertos
puertos_ssh () {
#msg -bar
#echo -e "\033[1;36m PUERTOS ACTIVOS"
#msg -bar2
PT=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
for porta in `echo -e "$PT" | cut -d: -f2 | cut -d' ' -f1 | uniq`; do
svcs=$(echo -e "$PT" | grep -w "$porta" | awk '{print $1}' | uniq)
#echo -e "\033[1;33m ➾ \e[1;31m $svcs :\033[1;33m ➢ \e[1;32m $porta   "
<font color="yellow"> ➾ </font><font color="red"> $svcs : </font><font color="yellow"> ➢ </font><font color="green"> $porta </font>
done
}

#SERVICE PYTHON DIREC
ureset_python () {
for port in $(cat /etc/newadm/PortPD.log| grep -v "nobody" |cut -d' ' -f1)
do
PIDVRF3="$(ps aux|grep pydic-"$port" |grep -v grep|awk '{print $2}')"
if [[ -z $PIDVRF3 ]]; then
screen -dmS pydic-"$port" python /etc/ger-inst/PDirect.py "$port"
NOM=`less /etc/newadm/ger-user/nombre.log` > /dev/null 2>&1
NOM1=`echo $NOM` > /dev/null 2>&1
IDB=`less /etc/newadm/ger-user/IDT.log` > /dev/null 2>&1
IDB1=`echo $IDB` > /dev/null 2>&1
KEY="862633455:AAGJ9BBJanzV6yYwLSemNAZAVwn7EyjrtcY"
URL="https://api.telegram.org/bot$KEY/sendMessage"
MSG="⚠️ AVISO DE VPS: $NOM1 ⚠️
❗️ Reiniciando Proxy-PhytonDirecto: $port ❗️ "
curl -s --max-time 10 -d "chat_id=$IDB1&disable_web_page_preview=1&text=$MSG" $URL
else
for pid in $(echo $PIDVRF3); do
echo""
done
fi
done
}

ureset_python

pidproxy3=$(ps x | grep -w  "PDirect.py" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy3 ]] && P3="<span class='encendido'> ACTIVO " || P3="<span class='detenido'> DESACTIVADO | REINICIANDO "
echo "<p>Estado del servicio PythonDirec está ||  $P3 </span>.</p> " >> $DIR/$ARCHIVO
#LIBERAR RAM,CACHE
#sync ; echo 3 > /proc/sys/vm/drop_caches ; echo "RAM Liberada"
# Finalmente, terminamos de escribir el archivo
echo "
#NUEVO
<font color="blue">PUERTOS ACTIVOS</font>
puertos_ssh
#NUEVO
</body>
</html>" >> $DIR/$ARCHIVO
