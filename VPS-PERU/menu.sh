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
name="\033[1;31mVPS\033[1;37m-PE\033[1;31mRU"
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
administrar_usuarios () {
bash <(curl -Ls https://raw.githubusercontent.com/ThonyDroidYT/Herramientas/main/VPS-PERU/usuarios.sh)
}
add_user () {
#nome senha Dias limite
[[ $(cat /etc/passwd |grep $1: |grep -vi [a-z]$1 |grep -v [0-9]$1 > /dev/null) ]] && return 1
valid=$(date '+%C%y-%m-%d' -d " +$3 days") && datexp=$(date "+%F" -d " + $3 days")
useradd -M -s /bin/false $1 -e ${valid} > /dev/null 2>&1 || return 1
(echo $2; echo $2)|passwd $1 2>/dev/null || {
    userdel --force $1
    return 1
    }
[[ -e ${USRdatabase} ]] && {
   newbase=$(cat ${USRdatabase}|grep -w -v "$1")
   echo "$1|$2|${datexp}|$4" > ${USRdatabase}
   for value in `echo ${newbase}`; do
   echo $value >> ${USRdatabase}
   done
   } || echo "$1|$2|${datexp}|$4" > ${USRdatabase}
}
    
mostrar_usuarios () {
for u in `awk -F : '$3 > 900 { print $1 }' /etc/passwd | grep -v "nobody" |grep -vi polkitd |grep -vi system-`; do
echo "$u"
done
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
echo -e "${cyan}Usuario:》${green} ${us}" 
#echo "${us}"
done
echo -e "${barra}"
fi
while true; do
     echo -e "${yellow}Nombre De Nuevo Usuario${plain}"
     read -p "Nombre: 》" nomeuser
     nomeuser="$(echo $nomeuser|sed -e 's/[^a-z0-9 -]//ig')"
     if [[ -z $nomeuser ]]; then
     err_fun 1 && continue
     elif [[ "${#nomeuser}" -lt "4" ]]; then
     err_fun 2 && continue
     elif [[ "${#nomeuser}" -gt "24" ]]; then
     err_fun 3 && continue
     elif [[ "$(echo ${usuarios_ativos[@]}|grep -w "$nomeuser")" ]]; then
     err_fun 14 && continue
     fi
     break
done
while true; do
     echo -e "${yellow}Contraseña de Nuevo Usuario${plain}"
     read -p "Contraseña: 》" senhauser
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
     echo -e "${yellow}Tiempo de Duración de Nuevo Usuario${plain}"
     read -p "Duración: 》" diasuser
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
     echo -e "${cyan}Limite de Conexión de Nuevo Usuario$plain}"
     read -p "Límite: 》" limiteuser
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
     echo -e "➾ Fecha de Expiración: " && echo -e "$(date "+%F" -d " + $diasuser days")"
     echo -e "➾ Limite de Conexión: " && echo -e "$limiteuser"
     echo -e "➾ Creado Con: ${name}"
echo""
puertos_ssh
echo -e "${barra}"
add_user "${nomeuser}" "${senhauser}" "${diasuser}" "${limiteuser}" && echo -e "${yellow}Usuario Creado Con Éxito" || echo -e "${green}Error, Usuario no creado"
[[ $(dpkg --get-selections|grep -w "openvpn"|head -1) ]] && [[ -e /etc/openvpn/openvpn-status.log ]] && newclient "$nomeuser" "$senhauser"
echo -e "${barra}"
}

#Sistema de Puertos
puertos_ssh () {
echo -e "${barra}"
echo -e "${cyan}      PUERTOS ACTIVOS  ${plain}"
echo -e "${barra}"
PT=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
NOREPEAT
for porta in `echo -e "$PT" | cut -d: -f2 | cut -d' ' -f1 | uniq`; do
[[ $(echo -e $NOREPEAT|grep -w "$porta") ]] && continue
NOREPEAT+="$porta\n"
svcs=$(echo -e "$PT" | grep -w "$porta" | awk '{print $1}' | uniq)
echo -e "\033[1;33m ➾ \e[1;31m $svcs\033[1;32m: \033[1;33m ➢ \e[1;32m $porta "
done
echo -e "${barra}"
}

#MENU SCRIPT
echo -e "${barra}"
echo -e "${Azul}        ${name}  ${green}[BY: @THONY_DROIDYT]     ${plain}"
echo -e "${barra}"
echo -e "${num1} ${cyan}ADMININISTRAR USUARIOS  ${plain}"
echo -e "${num2} ${cyan}CREAR USUARIO  ${plain}"
echo -e "${num3} ${cyan}PUERTOS ACTIVOS  ${plain}"
echo -e "${num4} ${cyan}FUNTION FOUR  ${plain}"
echo -e "${num5} ${cyan}FUNTION FIVE  ${plain}"
echo -e "${num0} ${red}EXIT SCRIPT ${plain}"
echo -e "${barra}"
#echo -e "${blue}SELECIONE UNA OPCIÓN: 》 ${yellow}"; read multiscripts
read -p "SELECIONE UNA OPCIÓN: 》" script
case $script in
0)
clear
exit;;
1)administrar_usuarios;;
2)new_user;;
3)puertos_ssh;;
4)funtion_four;;
5)funtion_five;;
*)echo -e "${red}¡POR FAVOR SELECIONE EL NÚMERO CORRECTO! ${plain}"
exit ;;
esac
