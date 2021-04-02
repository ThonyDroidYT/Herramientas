#!/bin/bash
#UserData
USRdatabase="/etc/newadm/RegV2ray"
mosusr_kk() {
clear 
clear
msg -bar
msg -tit
msg -ama "         USUARIOS REGISTRADOS | UUID V2RAY"
msg -bar
# usersss=$(cat ${USRdatabase}|cut -d '|' -f1)
# cat ${USRdatabase}|cut -d'|' -f3
VPSsec=$(date +%s)
local HOST="${USRdatabase}"
local HOST2="${USRdatabase}"
local RETURN="$(cat $HOST|cut -d'|' -f2)"
local IDEUUID="$(cat $HOST|cut -d'|' -f1)"
if [[ -z $RETURN ]]; then
echo -e "----- NINGUN USER REGISTRADO -----"
msg -ne "Enter Para Continuar" && read enter
${SCPinst}/v2ray.sh
else
i=1
echo -e "\e[97m                 UUID                | USER | EXPIRACION \e[93m"
msg -bar
while read hostreturn ; do
DateExp="$(cat ${USRdatabase}|grep -w "$hostreturn"|cut -d'|' -f3)"
if [[ ! -z $DateExp ]]; then             
DataSec=$(date +%s --date="$DateExp")
[[ "$VPSsec" -gt "$DataSec" ]] && EXPTIME="\e[91m[EXPIRADO]\e[97m" || EXPTIME="\e[92m[$(($(($DataSec - $VPSsec)) / 86400))]\e[97m Dias"
else
EXPTIME="\e[91m[ S/R ]"
fi 
usris="$(cat ${USRdatabase}|grep -w "$hostreturn"|cut -d'|' -f2)"
local contador_secuencial+="\e[93m$hostreturn \e[97m|\e[93m$usris\e[97m|\e[93m $EXPTIME \n"           
      if [[ $i -gt 30 ]]; then
	      echo -e "$contador_secuencial"
	  unset contador_secuencial
	  unset i
	  fi
let i++
done <<< "$IDEUUID"

[[ ! -z $contador_secuencial ]] && {
linesss=$(cat ${USRdatabase} | wc -l)
	      echo -e "$contador_secuencial \n Numero de Registrados: $linesss"
	}
fi
msg -bar
msg -ne "Enter Para Continuar" && read enter
${SCPinst}/v2ray.sh
}
#fin_user
TMPFILE="/root/tmp.json"
#V2RAYFILE="/usr/local/etc/v2ray/config.json"
V2RAYFILE="/etc/v2ray/config.json"
_banner_2 () {
  echo "==================================="
  echo "=      CREATED BY THONYDROID      ="
  echo "==================================="
}
barra () {
bash /etc/newadm/menu --barra
}
_banner () {
  barra
  echo -e "\033[0;34m=             \033[1;33mV2RAY MANAGER \033[1;32m[NEW-ADM-PLUS]              \033[0;34m=\e[0m"
  barra
}
display_uuid () {
  printf "\033[1;32mSUS UUID ACTIVOS\033[0m\n"
  x=0
  for i in $(jq -r ".inbounds[].settings.clients[].id" $V2RAYFILE)
  do
    printf "[\033[1;32m${x}\033[0m]\033[1;36m ${i}\033[0m\n"
    x=$((x+1))
  done
  printf "\n"
}
display_name () {
  printf "\033[1;32mSUS UUID ACTIVOS\033[0m\n"
  x=0
  for i in $(jq -r ".inbounds[].settings.clients[].id" $V2RAYFILE)
  do
    printf "[\033[1;32m${x}\033[0m]\033[1;36m ${i}\033[0m\n"
    x=$((x+1))
  done
  printf "\n\n"
}
ask_end () {
  read -r -p "$(printf '\033[1;32m¿Quieres continuar? \033[1;33m\033[1;32m[y/n] \033[1;33m\n')" CONFEXIT
  case $CONFEXIT in  
    y|Y) clear
    start_run ;; 
    n|N) printf '\033[1;32mOK, saliendo ... \033[1;33m\n'
      sleep 2
      exit
      ;; 
    *) printf "\033[1;31mSELECCIÓN INVÁLIDA. Solo se permiten y/n\033[0m\n"
      sleep 2
      clear
      start_run
      ;; 
  esac

}
#Display Menu
display_menu () {
  printf "\033[1;32m-- MENU --\033[0m\n"
  printf "[\033[1;32m1\033[0m]\033[1;36m AGREGAR\033[0m\n"
  printf "[\033[1;32m2\033[0m]\033[1;36m ELIMINAR\033[0m\n"
  printf "[\033[1;32m3\033[0m]\033[1;36m SALIR\033[0m\n"
  printf "[\033[1;32m4\033[0m]\033[1;36m Mostrar Usuarios \033[0m\n"
}
DoDelete_uuid () {
  jq 'del(.inbounds[].settings.clients['"$1"'])' $V2RAYFILE >> $TMPFILE
  cat $TMPFILE > $V2RAYFILE
  rm $TMPFILE
  printf "\033[1;32mHECHO\033[0m\n"
  systemctl restart v2ray &>/dev/null
  sleep 2
  if [[ "$ASKCONTINUE" == "true" ]]
  then
    ask_end
  fi
}
delete_uuid () {
  _banner
  display_uuid
  read -r -p "$(printf '\033[1;32m¿Cuál quieres borrar?\033[1;33m\n')" DELINPUT
  re='^[0-9]+$'
  if ! [[ $DELINPUT =~ $re ]] ; then
    printf "\033[1;31mELECCIÓN INVÁLIDA. Solo se permiten números\033[0m\n"
    sleep 2
    clear
    delete_uuid
  fi
  if [[ $(jq -r ".inbounds[].settings.clients[$DELINPUT].id" $V2RAYFILE) == null ]]
  then
    printf "\033[1;31mELECCIÓN INVALIDA\033[0m\n"
    sleep 2
    clear
    delete_uuid
  else
    printf "\033[1;32m¿Estás seguro de que quieres eliminar este UUID? \033[1;36m"$(jq -r ".inbounds[].settings.clients[$DELINPUT].id" $V2RAYFILE) "\033[1;33m\n"
    read -r -p "$(printf '\033[1;32m[y/n] \033[1;33m\n')" DELCONFINPUT
    case $DELCONFINPUT in  
      y|Y) DoDelete_uuid "$DELINPUT" ;; 
      n|N) printf '\033[1;32mOKEY \033[1;33m\n'
        sleep 2
        clear
        start_run
        ;; 
      *) printf "\033[1;31mELECCIÓN INVÁLIDA. Solo se permiten y/n\033[0m\n"
        sleep 2
        clear
        delete_uuid
        ;; 
    esac
  fi  
}
set_exp_date () {
  result=$(get_exp_date "${OPTEXP}")
  #croncmd="phcv2raymanager -d -u ${1} && ( crontab -l | grep -v -F 'phcv2raymanager -d -u ${1}') | crontab -"
  croncmd="v2plus -d -u ${1} && ( crontab -l | grep -v -F 'v2plus -d -u ${1}') | crontab -"
  cronjob="${result} * $croncmd"
  ( crontab -l | grep -v -F "$croncmd" ; echo "$cronjob" ) | crontab -
}
#New
DoUUIDAdd_fail (){
  email=${2}
  jq '.inbounds[].settings.clients[.inbounds[].settings.clients| length] |= . + {"id": "'"${1}"'","alterId": 0,"email": $email}' $V2RAYFILE >> $TMPFILE
  cat $TMPFILE > $V2RAYFILE
  rm $TMPFILE
  systemctl restart v2ray &>/dev/null
  if [[ "$OPTEXPA" == "true" ]]
  then
    set_exp_date "${1}"
  fi
  sleep 2
  if [[ "$ASKCONTINUE" == "true" ]]
  then
    ask_end
  fi
}
#Backup
DoUUIDAdd (){
  Expire=$(date "+%F" -d " + $INPEXPDATE days")
  jq '.inbounds[].settings.clients[.inbounds[].settings.clients| length] |= . + {"id": "'"${1}"'","level": 1,"alterId": 64}' $V2RAYFILE >> $TMPFILE
  echo "$1 | $Expire" >> /etc/newadm/RegV2ray
  cat $TMPFILE > $V2RAYFILE
  rm $TMPFILE
  systemctl restart v2ray &>/dev/null
  if [[ "$OPTEXPA" == "true" ]]
  then
    set_exp_date "${1}"
  fi
  sleep 2
  if [[ "$ASKCONTINUE" == "true" ]]
  then
    ask_end
  fi
}
add_existing_uuid () {
  read -r -p "$(printf '\033[1;32mIngrese el UUID: 》\033[1;33m\n')" UUIDINP
  #add uuid
  RAMDOM=$(cat /dev/urandom | tr -dc '[:alnum:]' | head -c 10)    
  read -r -p "$(printf '\033[1;32mIntroduce un correo o presiona Enter para generar uno \033[0m\n')" CORREO
  [ -z "$CORREO" ] && CORREO="$RAMDOM@gmail.com"
  printf "\033[1;33m CORREO: $CORREO \033[0m\n"
  read -r -p "$(printf '\033[1;32m¿Quiere agregar una fecha de vencimiento? [S/N]\033[1;33m\n')" ASKFOREXPDATE
  case $ASKFOREXPDATE in

    n|N|y|Y)
      read -r -p "$(printf '\033[1;32m¿Cuántos días?\033[1;33m\n')" INPEXPDATE
      if [[ -n ${input//[0-9]/} ]]; then
        printf "\033[1;31mELECCIÓN INVALIDA\033[0m\n"
        sleep 2
        clear
        add_existing_uuid
      else
        OPTEXPA="true"
        OPTEXP=$INPEXPDATE
        DoUUIDAdd "$UUIDINP"
      fi  
      ;;

    n|N)
      DoUUIDAdd "$UUIDINP" "$CORREO"
      ;;

    *)
      printf "\033[1;31mELECCIÓN INVALIDA\033[0m\n"
      sleep 2
      clear
      add_existing_uuid
      ;;
  esac
}
#add uuid new
add_generated_uuid () {

  #TheUUID=$(curl -skL -w #"\n" https://www.uuidgenerator.net/api/version4)
  #TheUUID=$(cat /proc/sys/kernel/random/uuid)
  TheUUID=`uuidgen`
  printf "\033[1;33mSu código UUID: 》\033[1;36m $TheUUID\033[0m\n"
  #add uuid
  RAMDOM=$(cat /dev/urandom | tr -dc '[:alnum:]' | head -c 10)    
  read -r -p "$(printf '\033[1;32mIntroduce un correo o presiona Enter para generar uno \033[0m\n')" CORREO
  [ -z "$CORREO" ] && CORREO="$RAMDOM@gmail.com"
  read -r -p "$(printf '\033[1;32m¿Quiere agregar una fecha de vencimiento? [s/n]\033[0m\n')" ASKFOREXPDATE
  case $ASKFOREXPDATE in

    s|S|y|Y)
      read -r -p "$(printf '\033[1;32m¿Cuántos días? \033[1;33m\n')" INPEXPDATE
      if [[ -n ${input//[0-9]/} ]]; then
        printf "\033[1;31mELECCIÓN INVALIDA\033[0m\n"
        sleep 2
        clear
        add_generated_uuid
      else
        OPTEXPA="true"
        OPTEXP=$INPEXPDATE
        DoUUIDAdd "$TheUUID" "$CORREO"
      fi  
      ;;

    n|N)
      DoUUIDAdd "$TheUUID" "$CORREO"
      ;;

    *)
      printf "\033[1;31mELECCIÓN INVALIDA\033[0m\n"
      sleep 2
      clear
      add_generated_uuid
      ;;
  esac
}
#sud menu 2
add_uuid () {
  clear
  _banner
  printf "\033[1;32m-- MENU --\033[0m\n"
  printf "[\033[1;32m1\033[0m]\033[1;36m Agregar UUID existente\033[0m\n"
  printf "[\033[1;32m2\033[0m]\033[1;36m Generar nuevo y luego agregar\033[0m\n"
    read -r -p "$(printf '\033[1;32m¿Qué es lo que quieres hacer?: 》\033[0m\n')" ADDINPUT


  case $ADDINPUT in

    1)
      add_existing_uuid
      ;;

    2)
      add_generated_uuid
      ;;

    *)
      printf "\033[1;31m ELECCIÓN INVALIDA\033[0m\n"
      sleep 2
      clear
      add_uuid
      ;;
  esac
}
#menu
start_run(){
  clear
  _banner
  display_uuid
  display_menu
  read -r -p "$(printf '\033[1;32m¿Qué es lo que quieres hacer?: 》\033[0m\n')" INPUT


  case $INPUT in

    1)
      printf '\033[1;32mOKEY \033[1;33m\n'
      add_uuid
      ;;

    2)
      printf '\033[1;32mOKEY \033[1;33m\n'
      sleep 2
      clear
      delete_uuid
      ;;
    3)
      printf '\033[1;32mOKEY \033[1;33m\n'
      sleep 2
      exit
      ;;
    4)
      barra
      printf '\033[1;32mDetalles de Usuarios \033[1;33m\n'
      barra
      detail_user
      barra
      ;;
    *)
      printf "\033[1;31mELECCIÓN INVALIDA\033[0m\n"
      sleep 2
      clear
      _banner
      start_run
      ;;
  esac
}

delete_uuid_by_id () {
  x=0
  for i in $(jq '.inbounds[].settings.clients[].id' $V2RAYFILE)
  do 
    if [[ "$i" == '"'$1'"' ]]
    then
      break
    else
      x=$((x+1))
    fi
  done
  DoDelete_uuid $x
}
get_exp_date () {
  NEW_expration_DATE=$(date -d "+${1} days" +'%d:%m')
  exp=(${NEW_expration_DATE//:/ })
  mm=${exp[1]}
  dd=${exp[0]}
  if [[ "${dd:0:1}" == 0 ]]
  then
    dd=${dd/0/''}
  fi
  if [[ "${mm:0:1}" == 0 ]]
  then
    mm=${mm/0/''}
  fi
  echo "0 0 ${dd} ${mm}"
}
print_help () {
  clear
  echo "===================================="
  echo "-a = Agregar UUID: solo marca"
  echo "-d = Eliminar UUID: solo marca"
  echo "-u = UUID: necesita una cadena después de la bandera"
  echo "-r = Aleatorio: solo bandera"
  echo "-h = Ayuda - solo bandera"
  echo "-n = Número: necesita int después de la bandera"
  barra
  #echo "===================================="
  echo "Cuando -a es aumentar -u o -r requerido"
  echo "Cuando -d es raise -n o -u requerido"
  echo "Cuando -h es aumento -a y -d no deben estar activos"
  #echo "===================================="
  barra
}
while getopts "a d r h n:u:e:" opt; do
  case "${opt}" in
    a) OPTADD="true" ;;
    d) OPTDEL="true" ;;
    u) 
      OPTUUIDA="true"
      OPTUUID=$OPTARG ;;
    r) OPTRAND="true" ;;
    h) OPTHELP="true" ;;
    n) 
      OPTNA="true"
      OPTN=$OPTARG ;;
    e) 
      OPTEXPA="true"
      OPTEXP=$OPTARG ;;
  esac
done

ASKCONTINUE="false"
if [[ "$OPTADD" == "true" ]] && [[ "$OPTDEL" == "true" ]] && [[ "$OPTHELP" == "true" ]]
then
  echo "-a y -d -h no se puede subir al mismo tiempo"
elif [[ "$OPTADD" == "true" ]] && [[ "$OPTDEL" == "true" ]]
then
  print_help
elif [[ "$OPTADD" == "true" ]] && [[ "$OPTHELP" == "true" ]]
then
  print_help
elif [[ "$OPTHELP" == "true" ]] && [[ "$OPTDEL" == "true" ]]
then
  print_help
elif [[ "$OPTADD" == "true" ]]
then
  if [[ "$OPTRAND" == "true" ]] && [[ "$OPTUUIDA" == "true" ]]
  then
    echo "-r y -u no se puede subir al mismo tiempo"
  elif [[ "$OPTRAND" == "true" ]]
  then
    add_generated_uuid
  elif [[ "$OPTUUIDA" == "true" ]]
  then
    DoUUIDAdd "$OPTUUID"
  else
    print_help
  fi
elif [[ "$OPTDEL" == "true" ]]
then
  if [[ "$OPTNA" == "true" ]]
  then
    DoDelete_uuid "$OPTN"
  elif [[ "$OPTUUIDA" == "true" ]]
  then
    delete_uuid_by_id "$OPTUUID"
  else
    print_help
  fi
elif [[ "$OPTHELP" == "true" ]]
then
  print_help
else
  ASKCONTINUE="true"
  start_run
fi
