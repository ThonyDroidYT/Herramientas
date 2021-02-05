#!/bin/bash
#BARRAS AZUL
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
num5='\033[1;32m [5] \033[1;31m>'
num6='\033[1;32m [6] \033[1;31m>'
num7='\033[1;32m [7] \033[1;31m>'
num8='\033[1;32m [8] \033[1;31m>'
num9='\033[1;32m [9] \033[1;31m>'
num10='\033[1;32m [10] \033[1;31m>'
num11='\033[1;32m [11] \033[1;31m>'
num12='\033[1;32m [12] \033[1;31m>'
num13='\033[1;32m [13] \033[1;31m>'
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
Morado="\033[45m"
Morado2="\033[105m"
Celeste="\033[46m"
Verde="\033[102m"
Verdecana="\033[42m"

#Actualizar Archivos
fun_update () {
apt-get update -y
apt-get upgrade -y
dpkg --configure -a
clear
}

declare -A TIMEUS
SCPdir="/etc/VPS-PERU"
SCPdir2="/etc/herramientas"
SCPusr="${SCPdir}/usuarios"
MyPID="${SCPusr}/pid-pe"
MyTIME="${SCPusr}/time-pe"
USRdatabase="/etc/PEuser"
#[[ -e ${MyPID} ]] && source ${MyPID} || touch ${MyPID}
#[[ -e ${MyTIME} ]] && source ${MyTIME} || touch ${MyTIME}
#[[ ! -e ${USRdatabase} ]] && touch ${USRdatabase}
#sort ${USRdatabase} | uniq > ${USRdatabase}tmp
#mv -f ${USRdatabase}tmp ${USRdatabase}
# Open VPN
newclient () {
#Nome #Senha
usermod -p $(openssl passwd -1 $2) $1
  while [[ ${newfile} != @(s|S|y|Y|n|N) ]]; do
echo -e "${barra}"
   read -p "Crear Archivo OpenVPN? [S/N]: " -e -i S newfile
   tput cuu1 && tput dl1
  done
if [[ ${newfile} = @(s|S) ]]; then
	# Generates the custom client.ovpn
	rm -rf /etc/openvpn/easy-rsa/pki/reqs/$1.req
	rm -rf /etc/openvpn/easy-rsa/pki/issued/$1.crt
	rm -rf /etc/openvpn/easy-rsa/pki/private/$1.key
	cd /etc/openvpn/easy-rsa/
	./easyrsa build-client-full $1 nopass > /dev/null 2>&1
	cd
	
	cp /etc/openvpn/client-common.txt ~/$1.ovpn
	echo "<ca>" >> ~/$1.ovpn
	cat /etc/openvpn/easy-rsa/pki/ca.crt >> ~/$1.ovpn
	echo "</ca>" >> ~/$1.ovpn
	echo "<cert>" >> ~/$1.ovpn
	cat /etc/openvpn/easy-rsa/pki/issued/$1.crt >> ~/$1.ovpn
	echo "</cert>" >> ~/$1.ovpn
	echo "<key>" >> ~/$1.ovpn
	cat /etc/openvpn/easy-rsa/pki/private/$1.key >> ~/$1.ovpn
	echo "</key>" >> ~/$1.ovpn
	echo "<tls-auth>" >> ~/$1.ovpn
	cat /etc/openvpn/ta.key >> ~/$1.ovpn
	echo "</tls-auth>" >> ~/$1.ovpn
	
  while [[ ${ovpnauth} != @(s|S|y|Y|n|N) ]]; do
    read -p "Colocar autentificación de usuario en el archivo? [S/N]: " -e -i S ovpnauth
    tput cuu1 && tput dl1
  done
  [[ ${ovpnauth} = @(s|S) ]] && sed -i "s;auth-user-pass;<auth-user-pass>\n$1\n$2\n</auth-user-pass>;g" ~/$1.ovpn
  cd $HOME
  zip ./$1.zip ./$1.ovpn > /dev/null 2>&1
  rm ./$1.ovpn > /dev/null 2>&1

  echo -e "\033[1;31mArchivo creado en: ($HOME/$1.zip)"
 fi
}
block_userfun () {
local USRloked="/etc/newadm-userlock"
local LIMITERLOG="${USRdatabase}/Limiter.log"
if [[ $2 = "-loked" ]]; then
[[ $(cat ${USRloked}|grep -w "$1 ]] && return 1
echo "USER: $1 (LOKED - MULTILOGUIN) $(date +%r)"
fi
if [[ $(cat ${USRloked}|grep -w "$1 ]]; then
usermod -U "$1" &>/dev/null
[[ -e ${USRloked} ]] && {
   newbase=$(cat ${USRloked}|grep -w -v "$1
   [[ -e ${USRloked} ]] && rm ${USRloked}
   for value in `echo ${newbase}`; do
   echo $value >> ${USRloked}
   done
   }
[[ -e ${LIMITERLOG} ]] && [[ $(cat ${LIMITERLOG}|grep -w "$1 ]] && {
   newbase=$(cat ${LIMITERLOG}|grep -w -v "$1
   [[ -e ${LIMITERLOG} ]] && rm ${LIMITERLOG}
   for value in `echo ${newbase}`; do
   echo $value >> ${LIMITERLOG}
   done
}
return 1
else
usermod -L "$1" &>/dev/null
echo $1 >> ${USRloked}
return 0
fi
}
#Sistema de Puertos
puertos_ssh () {
echo -e "${barra}"
echo -e "\033[1;36m PUERTOS ACTIVOS"
echo -e "${barra}"2
PT=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN
for porta in `echo -e "$PT" | cut -d: -f2 | cut -d' ' -f1 | uniq`; do
svcs=$(echo -e "$PT" | grep -w "$porta" | awk '{print $1}' | uniq)
echo -e "\033[1;33m ➾ \e[1;31m $svcs :\033[1;33m ➢ \e[1;32m $porta   "
done
}
#BlockUser
block_user () {
local USRloked="/etc/newadm-userlock"
[[ ! -e ${USRloked} ]] && touch ${USRloked}
usuarios_ativos=($(mostrar_usuarios))
if [[ -z ${usuarios_ativos[@]} ]]; then
echo -e "${green}Ningún Usuario Creado"
echo -e "${barra}"
return 1
else
echo -e "${yellow}Usuarios Actualmente Activos en el Servidor"
echo -e "${barra}"
Numb=0
for us in $(echo ${usuarios_ativos[@]}); do
if [[ $(cat ${USRloked}|grep -w "${us} ]]; then
echo -e "[$Numb] ->" && echo -e "\033[1;33m ${us} \033[1;31mLoked"
else
echo -e "[$Numb] ->" && echo -e "\033[1;33m ${us} \033[1;32mUnlocked"
fi
let Numb++
done
echo -e "${barra}"
fi
echo -e "${yellow}Digite o Selecione un Usuario"
echo -e "${barra}"
unset selection
while [[ ${selection} = "" ]]; do
echo -e"\033[1;37mSelect: " && read selection
tput cuu1 && tput dl1
done
if [[ ! $(echo "${selection}" | egrep '[^0-9]') ]]; then
usuario_del="${usuarios_ativos[$selection]}"
else
usuario_del="$selection"
fi
[[ -z $usuario_del ]] && {
     echo -e "${green}Error, Usuario Inválido"
     echo -e "${barra}"
     return 1
     }
[[ ! $(echo ${usuarios_ativos[@]}|grep -w "$usuario_del ]] && {
     echo -e "${green}Error, Usuario Inválido"
     echo -e "${barra}"
     return 1
     }
echo -e "Usuario Selecionado: 》" && echo -e"$usuario_del "
block_userfun "$usuario_del" && echo -e "${green}[Bloqueado]" || echo -e "${green}[Desbloqueado]"
echo -e "${barra}"
}
add_user () {
#nome senha Dias limite
[[ $(cat /etc/passwd |grep $1: |grep -vi [a-z]$1 |grep -v [0-9]$1 > /dev/null) ]] && return 1
valid=$(date '+%C%y-%m-%d' -d " +$3 days && datexp=$(date "+%F" -d " + $3 days
useradd -M -s /bin/false $1 -e ${valid} > /dev/null 2>&1 || return 1
(echo $2; echo $2)|passwd $1 2>/dev/null || {
    userdel --force $1
    return 1
    }
[[ -e ${USRdatabase} ]] && {
   newbase=$(cat ${USRdatabase}|grep -w -v "$1
   echo "$1|$2|${datexp}|$4" > ${USRdatabase}
   for value in `echo ${newbase}`; do
   echo $value >> ${USRdatabase}
   done
   } || echo "$1|$2|${datexp}|$4" > ${USRdatabase}
}
renew_user_fun () {
#nome dias
datexp=$(date "+%F" -d " + $2 days && valid=$(date '+%C%y-%m-%d' -d " + $2 days
chage -E $valid $1 2> /dev/null || return 1
[[ -e ${USRdatabase} ]] && {
   newbase=$(cat ${USRdatabase}|grep -w -v "$1
   useredit=$(cat ${USRdatabase}|grep -w "$1
   pass=$(echo $useredit|cut -d'|' -f2)
   limit=$(echo $useredit|cut -d'|' -f4)
   echo "$1|$pass|${datexp}|$limit" > ${USRdatabase}
   for value in `echo ${newbase}`; do
   echo $value >> ${USRdatabase}
   done
   }
}
edit_user_fun () {
#nome senha dias limite
(echo "$2" ; echo "$2" ) |passwd $1 > /dev/null 2>&1 || return 1
datexp=$(date "+%F" -d " + $3 days && valid=$(date '+%C%y-%m-%d' -d " + $3 days
chage -E $valid $1 2> /dev/null || return 1
[[ -e ${USRdatabase} ]] && {
   newbase=$(cat ${USRdatabase}|grep -w -v "$1
   echo "$1|$2|${datexp}|$4" > ${USRdatabase}
   for value in `echo ${newbase}`; do
   echo $value >> ${USRdatabase}
   done
   } || echo "$1|$2|${datexp}|$4" > ${USRdatabase}
}
rm_user () {
#nome
userdel --force "$1" &>/dev/null || return 1
[[ -e ${USRdatabase} ]] && {
   newbase=$(cat ${USRdatabase}|grep -w -v "$1
   for value in `echo ${newbase}`; do
   echo $value >> ${USRdatabase}
   done
   }
}
mostrar_usuarios () {
for u in `awk -F : '$3 > 900 { print $1 }' /etc/passwd | grep -v "nobody" |grep -vi polkitd |grep -vi system-`; do
echo "$u"
done
}
dropbear_pids () {
local pids
local port_dropbear=`ps aux | grep dropbear | awk NR==1 | awk '{print $17;}'`
cat /var/log/auth.log|grep "$(date|cut -d' ' -f2,3)" > /var/log/authday.log
# cat /var/log/auth.log|tail -1000 > /var/log/authday.log
local log=/var/log/authday.log
local loginsukses='Password auth succeeded'
[[ -z $port_dropbear ]] && return 1
for port in `echo $port_dropbear`; do
 for pidx in $(ps ax |grep dropbear |grep "$port" |awk -F" " '{print $1}'); do
  pids="${pids}$pidx\n"
 done
done
for pid in `echo -e "$pids"`; do
  pidlogs=`grep $pid $log |grep "$loginsukses" |awk -F" " '{print $3}'`
  i=0
    for pidend in $pidlogs; do
    let i++
    done
    if [[ $pidend ]]; then
    login=$(grep $pid $log |grep "$pidend" |grep "$loginsukses
    PID=$pid
    user=`echo $login |awk -F" " '{print $10}' | sed -r "s/'//g"`
    waktu=$(echo $login |awk -F" " '{print $2"-"$1,$3}')
    [[ -z $user ]] && continue
    echo "$user|$PID|$waktu"
    fi
done
}
openvpn_pids () {
#nome|#loguin|#rcv|#snd|#time
  byte () {
   while read B dummy; do
   [[ "$B" -lt 1024 ]] && echo "${B} bytes" && break
   KB=$(((B+512)/1024))
   [[ "$KB" -lt 1024 ]] && echo "${KB} Kb" && break
   MB=$(((KB+512)/1024))
   [[ "$MB" -lt 1024 ]] && echo "${MB} Mb" && break
   GB=$(((MB+512)/1024))
   [[ "$GB" -lt 1024 ]] && echo "${GB} Gb" && break
   echo $(((GB+512)/1024)) terabytes
   done
   }
for user in $(mostrar_usuarios); do
user="$(echo $user|sed -e 's/[^a-z0-9 -]//ig')"
[[ ! $(sed -n "/^${user},/p" /etc/openvpn/openvpn-status.log) ]] && continue
i=0
unset RECIVED; unset SEND; unset HOUR
 while read line; do
 IDLOCAL=$(echo ${line}|cut -d',' -f2)
 RECIVED+="$(echo ${line}|cut -d',' -f3)+"
 SEND+="$(echo ${line}|cut -d',' -f4)+"
 DATESEC=$(date +%s --date="$(echo ${line}|cut -d',' -f5|cut -d' ' -f1,2,3,4)
 TIMEON="$(($(date +%s)-${DATESEC}))"
  MIN=$(($TIMEON/60)) && SEC=$(($TIMEON-$MIN*60)) && HOR=$(($MIN/60)) && MIN=$(($MIN-$HOR*60))
  HOUR+="${HOR}h:${MIN}m:${SEC}s\n"
  let i++
 done <<< "$(sed -n "/^${user},/p" /etc/openvpn/openvpn-status.log)"
RECIVED=$(echo $(echo ${RECIVED}0|bc)|byte)
SEND=$(echo $(echo ${SEND}0|bc)|byte)
HOUR=$(echo -e $HOUR|sort -n|tail -1)
echo -e "$user|$i|$RECIVED|$SEND|$HOUR"
done
}
err_fun () {
     case $1 in
     1)echo -e "${green}Usuario Nulo"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     2)echo -e "${green}Usuario Con Nombre Muy Curto"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     3)echo -e "${green}Usuario Con Nombre Muy Grande"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     4)echo -e "${green}Contraseña Nula"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     5)echo -e "${green}Contraseña Muy Corta"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     6)echo -e "${green}Contraseña Muy Grande"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     7)echo -e "${green}Duración Nula"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     8)echo -e "${green}Duración invalida utilize numeros"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     9)echo -e "${green}La Duración maxima es de un año"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     11)echo -e "${green}Limite Nulo"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     12)echo -e "${green}Limite Inválido utilize numeros"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     13)echo -e "${green}EL Limite maximo es de 999"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     14)echo -e "${green}El Usuario ya Existe"; sleep 2s; tput cuu1; tput dl1; tput cuu1; tput dl1;;
     esac
}
new_user () {
usuarios_ativos=($(mostrar_usuarios))
if [[ -z ${usuarios_ativos[@]} ]]; then
echo -e "${green}Ningún Usuario Creado"
echo -e "${barra}"
else
echo -e "${yellow}Usuarios Actualmente Activos en el Servidor"
echo -e "${barra}"
for us in $(echo ${usuarios_ativos[@]}); do
echo -e "User: " && echo "${us}"
done
echo -e "${barra}"
fi
while true; do
     echo -e "Nombre De Nuevo Usuario"
     read -p ": 》" nomeuser
     nomeuser="$(echo $nomeuser|sed -e 's/[^a-z0-9 -]//ig')"
     if [[ -z $nomeuser ]]; then
     err_fun 1 && continue
     elif [[ "${#nomeuser}" -lt "4" ]]; then
     err_fun 2 && continue
     elif [[ "${#nomeuser}" -gt "24" ]]; then
     err_fun 3 && continue
     elif [[ "$(echo ${usuarios_ativos[@]}|grep -w "$nomeuser" ]]; then
     err_fun 14 && continue
     fi
     break
done
while true; do
     echo -e "Contraseña de Nuevo Usuario"
     read -p ": 》" senhauser
     if [[ -z $senhauser ]]; then
     err_fun 4 && continue
     elif [[ "${#senhauser}" -lt "6" ]]; then
     err_fun 5 && continue
     elif [[ "${#senhauser}" -gt "20" ]]; then
     err_fun 6 && continue
     fi
     break
done
while true; do
     echo -e "Tiempo de Duración de Nuevo Usuario"
     read -p ": 》" diasuser
     if [[ -z "$diasuser" ]]; then
     err_fun 7 && continue
     elif [[ "$diasuser" != +([0-9]) ]]; then
     err_fun 8 && continue
     elif [[ "$diasuser" -gt "360" ]]; then
     err_fun 9 && continue
     fi 
     break
done
while true; do
     echo -e "Limite de Conexión de Nuevo Usuario"
     read -p ": 》" limiteuser
     if [[ -z "$limiteuser" ]]; then
     err_fun 11 && continue
     elif [[ "$limiteuser" != +([0-9]) ]]; then
     err_fun 12 && continue
     elif [[ "$limiteuser" -gt "999" ]]; then
     err_fun 13 && continue
     fi
     break
done
     tput cuu1 && tput dl1
     tput cuu1 && tput dl1
     tput cuu1 && tput dl1
     tput cuu1 && tput dl1
     echo -e "➾ IP del Servidor: " && echo -e "$(meu_ip)"
     echo -e "➾ Usuario: " && echo -e "$nomeuser"
     echo -e "➾ Contraseña: " && echo -e "$senhauser"
     echo -e "➾ Dias de Duración: " && echo -e "$diasuser"
     echo -e "➾ Fecha de Expiración: " && echo -e "$(date "+%F" -d " + $diasuser days"
     echo -e "➾ Limite de Conexión: " && echo -e "$limiteuser"
     echo -e "➾ Creado Con: NEW-ADM-PLUS "
echo""
puertos_ssh
echo -e "${barra}"
add_user "${nomeuser}" "${senhauser}" "${diasuser}" "${limiteuser}" && echo -e "${yellow}Usuario Creado Con Éxito" || echo -e "${green}Error, Usuario no creado"
[[ $(dpkg --get-selections|grep -w "openvpn"|head -1) ]] && [[ -e /etc/openvpn/openvpn-status.log ]] && newclient "$nomeuser" "$senhauser"
echo -e "${barra}"
}
remove_user () {
usuarios_ativos=($(mostrar_usuarios))
if [[ -z ${usuarios_ativos[@]} ]]; then
echo -e "${green}Ningún Usuario Registrado!"
echo -e "${barra}"
return 1
else
echo -e "${yellow}Usuarios Actualmente Activos en el Servidor"
echo -e "${barra}"
i=0
for us in $(echo ${usuarios_ativos[@]}); do
echo -e "[$i] ->" && echo -e "\033[1;33m ${us}"
let i++
done
echo -e "${barra}"
fi
echo -e "${yellow}Digite o Seleccioné un Usuario"
echo -e "${barra}"
unset selection
while [[ -z ${selection} ]]; do
echo -e"\033[1;37mSelecione A Opción: 》" && read selection
tput cuu1 && tput dl1
done
if [[ ! $(echo "${selection}" | egrep '[^0-9]') ]]; then
usuario_del="${usuarios_ativos[$selection]}"
else
usuario_del="$selection"
fi
[[ -z $usuario_del ]] && {
     echo -e "${green}Error, Usuario Invalidó"
     echo -e "${barra}"
     return 1
     }
[[ ! $(echo ${usuarios_ativos[@]}|grep -w "$usuario_del ]] && {
     echo -e "${green}Error, Usuario Invalido"
     echo -e "${barra}"
     return 1
     }
echo -e "Usuario Selecionado: " && echo -e"$usuario_del"
rm_user "$usuario_del" && echo -e "${green} [Removido]" || echo -e "${green} [No Removido]"
echo -e "${barra}"
}
renew_user () {
usuarios_ativos=($(mostrar_usuarios))
if [[ -z ${usuarios_ativos[@]} ]]; then
echo -e "${green}Ningún Usuario Creado"
echo -e "${barra}"
return 1
else
echo -e "${yellow}Usuarios Actualmente Activos en el  Servidor"
echo -e "${barra}"
i=0
for us in $(echo ${usuarios_ativos[@]}); do
echo -e "[$i] ->" && echo -e "\033[1;33m ${us}"
let i++
done
echo -e "${barra}"
fi
echo -e "${yellow}Digite o Selecione un Usuario"
echo -e "${barra}"
unset selection
while [[ -z ${selection} ]]; do
echo -e"\033[1;37mSelecione una Opción: 》" && read selection
tput cuu1
tput dl1
done
if [[ ! $(echo "${selection}" | egrep '[^0-9]') ]]; then
useredit="${usuarios_ativos[$selection]}"
else
useredit="$selection"
fi
[[ -z $useredit ]] && {
     echo -e "${green}Error, Usuario Invalido"
     echo -e "${barra}"
     return 1
     }
[[ ! $(echo ${usuarios_ativos[@]}|grep -w "$useredit ]] && {
     echo -e "${green}Error, Usuario Invalido"
     echo -e "${barra}"
     return 1
     }
while true; do
     echo -e "Nuevo Tiempo de Duración de: $useredit"
     read -p ": 》" diasuser
     if [[ -z "$diasuser" ]]; then
     echo -e '\n\n\n'
     err_fun 7 && continue
     elif [[ "$diasuser" != +([0-9]) ]]; then
     echo -e '\n\n\n'
     err_fun 8 && continue
     elif [[ "$diasuser" -gt "360" ]]; then
     echo -e '\n\n\n'
     err_fun 9 && continue
     fi
     break
done
echo -e "${barra}"
renew_user_fun "${useredit}" "${diasuser}" && echo -e "${yellow}Usuario Modificado Con Éxito" || echo -e "${green}Error, Usuario no Modificado"
echo -e "${barra}"
}
edit_user () {
usuarios_ativos=($(mostrar_usuarios))
if [[ -z ${usuarios_ativos[@]} ]]; then
echo -e "${green}Ningún Usuario Registrado"
echo -e "${barra}"
return 1
else
echo -e "${yellow}Usuarios Atualmente Activos en el Servidor"
echo -e "${barra}"
i=0
for us in $(echo ${usuarios_ativos[@]}); do
echo -e "[$i] ->" && echo -e "\033[1;33m ${us}"
let i++
done
echo -e "${barra}"
fi
echo -e "${yellow}Digite o Selecione un Usuario"
echo -e "${barra}"
unset selection
while [[ -z ${selection} ]]; do
echo -e"\033[1;37mSelecione una Opción: " && read selection
tput cuu1; tput dl1
done
if [[ ! $(echo "${selection}" | egrep '[^0-9]') ]]; then
useredit="${usuarios_ativos[$selection]}"
else
useredit="$selection"
fi
[[ -z $useredit ]] && {
     echo -e "${green}Error, Usuario Invalido"
     echo -e "${barra}"
     return 1
     }
[[ ! $(echo ${usuarios_ativos[@]}|grep -w "$useredit ]] && {
     echo -e "${green}Error, Usuario Invalido"
     echo -e "${barra}"
     return 1
     }
while true; do
echo -e "Usuario Selecionado: " && echo -e "$useredit"
     echo -e "Nueva Contraseña de: $useredit"
     read -p ": 》" senhauser
     if [[ -z "$senhauser" ]]; then
     err_fun 4 && continue
     elif [[ "${#senhauser}" -lt "6" ]]; then
     err_fun 5 && continue
     elif [[ "${#senhauser}" -gt "20" ]]; then
     err_fun 6 && continue
     fi
     break
done
while true; do
     echo -e "Dias de Duración de: $useredit"
     read -p ": 》" diasuser
     if [[ -z "$diasuser" ]]; then
     err_fun 7 && continue
     elif [[ "$diasuser" != +([0-9]) ]]; then
     err_fun 8 && continue
     elif [[ "$diasuser" -gt "360" ]]; then
     err_fun 9 && continue
     fi
     break
done
while true; do
     echo -e "Nuevo Limite de Conexión de: $useredit"
     read -p ": 》" limiteuser
     if [[ -z "$limiteuser" ]]; then
     err_fun 11 && continue
     elif [[ "$limiteuser" != +([0-9]) ]]; then
     err_fun 12 && continue
     elif [[ "$limiteuser" -gt "999" ]]; then
     err_fun 13 && continue
     fi
     break
done
     tput cuu1 && tput dl1
     tput cuu1 && tput dl1
     tput cuu1 && tput dl1
     tput cuu1 && tput dl1
     echo -e "➾ IP del Servidor: " && echo -e "$(meu_ip)"
     echo -e "➾ Usuario: " && echo -e "$useredit"
     echo -e "➾ Contraseña: " && echo -e "$senhauser"
     echo -e "➾ Dias de Duración: " && echo -e "$diasuser"
     echo -e "➾ Fecha de Expiración: " && echo -e "$(date "+%F" -d " + $diasuser days"
     echo -e "➾ Limite de Conexión: " && echo -e "$limiteuser"
     echo -e "➾ Editado Con: NEW-ADM-PLUS"
echo""
puertos_ssh
echo -e "${barra}"
edit_user_fun "${useredit}" "${senhauser}" "${diasuser}" "${limiteuser}" && echo -e "${yellow}Usuario Modificado Con Éxito" || echo -e "${green}Error, Usuario no Modificado"
echo -e "${barra}"
}
detail_user () {
red=$(tput setaf 1)
gren=$(tput setaf 2)
yellow=$(tput setaf 3)
if [[ ! -e "${USRdatabase}" ]]; then
echo -e "${green}No Fue Identificado una Base de Datos Con Usuarios"
echo -e "${green}Los Usuarios a Seguir No Contienen Ninguna Información"
echo -e "${barra}"2
fi
txtvar=$(printf '%-16s' "USUARIO
txtvar+=$(printf '%-16s' "CONTRASEÑA
txtvar+=$(printf '%-16s' "EXPIRACIÓN
txtvar+=$(printf '%-6s' "LIMITE
echo -e "\033[1;33m${txtvar}"
echo -e "${barra}"2
VPSsec=$(date +%s)
while read user; do
unset txtvar
data_user=$(chage -l "$user" |grep -i co |awk -F ":" '{print $2}')
txtvar=$(printf '%-21s' "${yellow}$user
if [[ -e "${USRdatabase}" ]]; then
  if [[ $(cat ${USRdatabase}|grep -w "${user} ]]; then
    txtvar+="$(printf '%-21s' "${yellow}$(cat ${USRdatabase}|grep -w "${user}"|cut -d'|' -f2)"
    DateExp="$(cat ${USRdatabase}|grep -w "${user}"|cut -d'|' -f3)"
    DataSec=$(date +%s --date="$DateExp")
    if [[ "$VPSsec" -gt "$DataSec" ]]; then    
    EXPTIME="${red}[Exp]"
    else
    EXPTIME="${gren}[$(($(($DataSec - $VPSsec)) / 86400))]"
    fi
    txtvar+="$(printf '%-26s' "${yellow}${DateExp}${EXPTIME}"
    txtvar+="$(printf '%-11s' "${yellow}$(cat ${USRdatabase}|grep -w "${user}"|cut -d'|' -f4)"
    else
    txtvar+="$(printf '%-21s' "${red}???"
    txtvar+="$(printf '%-21s' "${red}???"
    txtvar+="$(printf '%-11s' "${red}???"
  fi
fi
echo -e "$txtvar"
done <<< "$(mostrar_usuarios)"
echo -e "${barra}"2
}
monit_user () {
yellow=$(tput setaf 3)
gren=$(tput setaf 2)
echo -e "${green}Monitor de Conexiones de Usuarios"
echo -e "${barra}"
txtvar=$(printf '%-13s' " USUARIO 
txtvar+=$(printf '%-19s' " CONEXIÓN 
txtvar+=$(printf '%-16s' "  TIEMPO/ACTIVO 
echo -e "\033[1;33m${txtvar}"
echo -e "${barra}"
while read user; do
 _=$(
PID="0+"
[[ $(dpkg --get-selections|grep -w "openssh"|head -1) ]] && PID+="$(ps aux|grep -v grep|grep sshd|grep -w "$user"|grep -v root|wc -l)+"
[[ $(dpkg --get-selections|grep -w "dropbear"|head -1) ]] && PID+="$(dropbear_pids|grep -w "${user}"|wc -l)+"
[[ $(dpkg --get-selections|grep -w "openvpn"|head -1) ]] && [[ -e /etc/openvpn/openvpn-status.log ]] && [[ $(openvpn_pids|grep -w "$user"|cut -d'|' -f2) ]] && PID+="$(openvpn_pids|grep -w "$user"|cut -d'|' -f2)+"
PID+="0"
TIMEON="${TIMEUS[$user]}"
[[ -z $TIMEON ]] && TIMEON=0
MIN=$(($TIMEON/60))
SEC=$(($TIMEON-$MIN*60))
HOR=$(($MIN/60))
MIN=$(($MIN-$HOR*60))
HOUR="${HOR}h:${MIN}m:${SEC}s"
[[ -z $(cat ${USRdatabase}|grep -w "${user} ]] && MAXUSER="?" || MAXUSER="$(cat ${USRdatabase}|grep -w "${user}"|cut -d'|' -f4)"
[[ $(echo $PID|bc) -gt 0 ]] && user="$user [\033[1;32mON\033[0m${yellow}]" || user="$user [\033[1;31mOFF\033[0m${yellow}]"
TOTALPID="$(echo $PID|bc)/$MAXUSER"
 while [[ ${#user} -lt 45 ]]; do
 user=$user" "
 done
 while [[ ${#TOTALPID} -lt 13 ]]; do
 TOTALPID=$TOTALPID" "
 done
 while [[ ${#HOUR} -lt 8 ]]; do
 HOUR=$HOUR" "
 done
echo -e "${yellow}$user $TOTALPID $HOUR" >&2
) &
pid=$!
sleep 0.5s
done <<< "$(mostrar_usuarios)"
while [[ -d /proc/$pid ]]; do
sleep 1s
done
echo -e "${barra}"
}
rm_vencidos () {
red=$(tput setaf 1)
gren=$(tput setaf 2)
yellow=$(tput setaf 3)
txtvar=$(printf '%-25s' "USUARIO
txtvar+=$(printf '%-20s' "VALIDEZ
echo -e "\033[1;33m${txtvar}"
echo -e "${barra}"
expired="${red}Expirado"
valid="${gren}Usuario Valido"
never="${yellow}Usuario Ilimitado"
removido="${red}Removido"
DataVPS=$(date +%s)
while read user; do
DataUser=$(chage -l "${user}" |grep -i co|awk -F ":" '{print $2}')
usr=$user
 while [[ ${#usr} -lt 20 ]]; do
 usr=$usr" "
 done
[[ "$DataUser" = " never" ]] && {
   echo -e "${yellow}$usr $never"
   continue
   }
DataSEC=$(date +%s --date="$DataUser)
if [[ "$DataSEC" -lt "$DataVPS" ]]; then
echo -e"${yellow}$usr $expired"
rm_user "$user" && echo -e "($removido)"
else
echo -e "${yellow}$usr $valid"
fi
done <<< "$(mostrar_usuarios)"
echo -e "${barra}"
}

backup_fun () {
echo -e "${yellow}HERRAMIENTA DE BACKUP DE USUARIOS"
echo -e "${barra}"
echo -e "${num1} ${cyan}CREAR BACKUP ${plain}"
echo -e "${num2} ${cyan}RESTAURAR BACKUP ${plain}"
echo -e "${barra}"
unset selection
while [[ ${selection} != @([1-2]) ]]; do
echo -e"\033[1;37mSelecione una Opción: " && read selection
tput cuu1 && tput dl1
done
case ${selection} in
1)
cp ${USRdatabase} $HOME/Backup-adm
echo -e "Procedimento Feito"
echo -e "\033[1;31mBACKUP > [\033[1;32m$HOME/Backup-adm\033[1;31m]"
;;
2)
while [[ ! -e ${dirbackup} ]]; do
echo -e"\033[1;37mDigite el Directorio Local De Backup: " && read dirbackup
tput cuu1 && tput dl1
done
VPSsec=$(date +%s)
while read line; do
nome=$(echo ${line}|cut -d'|' -f1)
[[ $(echo $(mostrar_usuarios)|grep -w "$nome ]] && {
  echo -e "${green}$nome [ERROR]"
  continue
  }
senha=$(echo ${line}|cut -d'|' -f2)
DateExp=$(echo ${line}|cut -d'|' -f3)
DataSec=$(date +%s --date="$DateExp
[[ "$VPSsec" -lt "$DataSec" ]] && dias="$(($(($DataSec - $VPSsec)) / 86400))" || dias="30"
limite=$(echo ${line}|cut -d'|' -f4)
add_user "$nome" "$senha" "$dias" "$limite" && echo -e "${green}$nome [OK]" || echo -e "${green}$nome [ERROR]"
done < ${dirbackup}
;;
esac
echo -e "${barra}"
}

baner_fun () {
local2="/etc/dropbear/banner"
chk=$(cat /etc/ssh/sshd_config | grep -v "Banner")
while read line; do
echo "$line" >> /tmp/ssh-conf
done <<< "$chk"
mv -f /tmp/ssh-conf /etc/ssh/sshd_config
echo "Banner /etc/bannerssh" >> /etc/ssh/sshd_config
local="/etc/bannerssh"
echo -e "${green}Bienvenido este es el instalador de Banner de ADM-PLUS"
echo -e "${barra}"
echo -e "digite un mensaje principal de banner: " && read ban_ner
echo -e " \033[1;32m[1] >\033[1;32m Verde"
echo -e " \033[1;32m[2] >\033[1;31m Rojo"
echo -e " \033[1;32m[3] >\033[1;34m Azul"
echo -e " \033[1;32m[4] >\033[1;33m Amarillo"
echo -e " \033[1;32m[5] >\033[1;35m Morado"
echo -e " \033[1;32m[6] >\033[198m Rosado"
echo -e " \033[1;32m[7] >\033[0;36m Celeste"
echo -e " \033[1;32m[8] >\033[0;33m Marrón"
echo -e " \033[1;32m[9] >\033[0;33m Naranja"
echo -e "Perfecto Ahora un Color: " && read ban_ner_cor
echo '<h2><font color="red">★━━━━━━✩━━━━━━★</font></h2>' > $local
if [[ "$ban_ner_cor" = "1" ]]; then
echo '<h1><font color="green">' >> $local
elif [[ "$ban_ner_cor" = "2" ]]; then
echo '<h1><font color="red">' >> $local
elif [[ "$ban_ner_cor" = "3" ]]; then
echo '<h1><font color="blue">' >> $local
elif [[ "$ban_ner_cor" = "4" ]]; then
echo '<h1><font color="yellow">' >> $local
elif [[ "$ban_ner_cor" = "5" ]]; then
echo '<h1><font color="purple">' >> $local
elif [ "$ban_ner_cor" = "6" ]; then
echo '<h6><font color="#e91e6e">' >> $local
elif [ "$ban_ner_cor" = "7" ]; then
echo '<h6><font color="#00aae4">' >> $local
elif [ "$ban_ner_cor" = "8" ]; then
echo '<h6><font color="#663b2a">' >> $local
elif [ "$ban_ner_cor" = "9" ]; then
echo '<h6><font color="#ff6600">' >> $local
else
echo '<h1><font color="blue">' >> $local
fi
echo "$ban_ner" >> $local
echo '</font></h1>' >> $local
echo '<h2><font color="red">★━━━━━━✩━━━━━━★</font></h2>' >> $local
txt_font () {
echo -e "digite un mensaje secundario: " && read ban_ner2
echo -e " \033[1;32m[1] >\033[1;32m Verde"
echo -e " \033[1;32m[2] >\033[1;31m Rojo"
echo -e " \033[1;32m[3] >\033[1;34m Azul"
echo -e " \033[1;32m[4] >\033[1;33m Amarillo"
echo -e " \033[1;32m[5] >\033[1;35m Morado"
echo -e " \033[1;32m[6] >\033[198m Rosado"
echo -e " \033[1;32m[7] >\033[0;36m Celeste"
echo -e " \033[1;32m[8] >\033[0;33m Marrón"
echo -e " \033[1;32m[9] >\033[0;33m Anaranjado"
echo -e "Perfecto Ahora un Color: " && read ban_ner2_cor
if [ "$ban_ner2_cor" = "1" ]; then
echo '<h6><font color="green">' >> $local
elif [ "$ban_ner2_cor" = "2" ]; then
echo '<h6><font color="red">' >> $local
elif [ "$ban_ner2_cor" = "3" ]; then
echo '<h6><font color="blue">' >> $local
elif [ "$ban_ner2_cor" = "4" ]; then
echo '<h6><font color="yellow">' >> $local
elif [ "$ban_ner2_cor" = "5" ]; then
echo '<h6><font color="purple">' >> $local
elif [ "$ban_ner2_cor" = "6" ]; then
echo '<h6><font color="#e91e6e">' >> $local
elif [ "$ban_ner2_cor" = "7" ]; then
echo '<h6><font color="#00aae4">' >> $local
elif [ "$ban_ner2_cor" = "8" ]; then
echo '<h6><font color="#663b2a">' >> $local
elif [ "$ban_ner2_cor" = "9" ]; then
echo '<h6><font color="#ff6600">' >> $local
else
echo '<h6><font color="red">' >> $local
fi
echo "$ban_ner2" >> $local
echo "</h6></font>" >> $local
}
while true; do
echo -e "Agregar Mensaje Secundario? [S/N]: " && read sin_nao
if [[ "$sin_nao" = @(s|S|y|Y) ]]; then
txt_font
elif [[ "$sin_nao" = @(n|N) ]]; then
break
fi
done
#Mensaje Final
echo '<p style="text-align: center;"><font color="red">ADM</font><font color="magenta">•</font><font color="blue">Plus®</font><font color="red"> | </font><font color="green">By:  @Thony_DroidYT</p>' >> $local
#Fin Mensaje Final
echo '<h2><font color="blue">★━━━━━━✩━━━━━━★</font></h2>' >> $local
if [[ -e "$local2" ]]; then
rm $local2  > /dev/null 2>&1
cp $local $local2 > /dev/null 2>&1
fi
echo -e "${barra}" && echo -e "${green}Banner Agregado Con Éxito" && echo -e "${barra}"
service ssh restart > /dev/null 2>&1 &
service sshd restart > /dev/null 2>&1 & 
service dropbear restart > /dev/null 2>&1 &
}
#Banner Dropbear
banner_dropbear () {
local="/etc/bannerssh"
local2="/etc/dropbear/banner"
rm -rf $local  > /dev/null 2>&1
rm -rf $local2  > /dev/null 2>&1
echo -e "${green}Bienvenido este es el instalador de BANNER-SSH/DROPBEAR"
echo -e "${barra}"
echo -e "Escriba el mensaje principal del BANNER de preferencia en HTML: \n" && read -p "BANNER: 》" banner
echo -e "${barra}"
echo "$banner" >> $local2
echo '<p style="text-align: center;"><font color="red">ADM</font><font color="yellow">•</font><font color="blue">Plus®</font><font color="red"> | </font><font color="green">By:  @Thony_DroidYT</p>' >> $local2
#echo '<p style="text-align: center;"><strong><span style="color: #ff0000;">ADM&bull;PLUS&reg;</span> |&nbsp;</strong><span style="color: #0000ff;"><strong>By: @Thony_DroidYT</strong></span></p>' >> $local2
echo -e "${green}Banner Dropbear Agregado Con ¡¡EXITO!!" && echo -e "${barra}"
service dropbear stop 2>/dev/null
service sshd restart 2>/dev/null
service dropbear restart 2>/dev/null
sleep 3s
}

menu_user () {
echo -e "${barra}"
echo -e "${azul}         ${red}ADMINISTRAR USUARIOS    ${plain}"
echo -e "${barra}"
echo -e "${num1} ${cyan}CREAR NUEVO USUARIO ${plain}" 
echo -e "${num2} ${cyan}CREAR USUARIO TEMPORAL ${plain}"
echo -e "${num3} ${cyan}REMOVER USUARIO ${plain}"
echo -e "${num4} ${cyan}BLOQUEAR O DESBLOQUEAR USUARIO ${plain}"
echo -e "${num5} ${cyan}EDITAR USUARIO ${plain}"
echo -e "${num6} ${cyan}RENOVAR USUARIO ${plain}"
echo -e "${num7} ${cyan}DETALLES DE TODOS LOS USUARIOS ${plain}"
echo -e "${num8} ${cyan}MONITOR DE USUARIOS CONECTADOS ${plain}"
echo -e "${num9} ${cyan}ELIMINAR USUARIOS VENCIDOS ${plain}"
echo -e "${num10} ${cyan}RESPALDAR USUARIOS ${plain}"
echo -e "${num11} ${cyan}BANNER SSH ${plain}"
echo -e "${num12} ${cyan}BANNER HTML ${plain}"
echo -e "${num0} REGRESAR"
echo -e "${barra}"
read -p "OPCIÓN: 》 " selection
case $selection in
1)new_user;;
2)${SCPdir2}/Crear-Demo.sh "${idioma}";;
3)remove_user;;
4)block_user;;
5)edit_user;;
6)renew_user;;
7)detail_user;;
8)monit_user;;
9)rm_vencidos;;
10)backup_fun;;
11)baner_fun;;
12)banner_dropbear;;
13)bash <(curl -Ls https://raw.githubusercontent.com/ThonyDroidYT/Herramientas/main/BannerPro.sh);;
esac
}
menu_user
