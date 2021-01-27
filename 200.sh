#!/bin/bash
#BARRA AZUL
barra="\033[1;34m======================================================\033[0m"
#barra="\033[1;34m**********************************************************\033[0m"
#barra="\033[1;34m+++++++++++++++++++++++++++++++++++++++++++++++++++++++\033[0m"
#barra="\033[1;34m###############################################\033[0m"
#barra="\033[1;34m_____________________________________________________\033[0m"

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

#Actualizar Archivos
fun_update () {
apt-get update -y
apt-get upgrade -y
dpkg --configure -a
clear
}

cambiar_status () {
msgsocks=$(cat /etc/ger-inst/PDirect.py | grep -E "MSG =" | awk -F = '{print $2}' | cut -d "'" -f 2)
echo -e "${barra}"
echo -e "\E[;1;36m            STATUS SOCKSPYTHON DIRECTO             \E[0m"
echo -e "${barra}"
echo -e "\033[1;31mSTATUS ACTUAL: \033[1;32m$msgsocks"
echo -e ""
echo -ne "\033[1;33mINGRESE SU NUEVO STATUS\033[1;33m: 》\033[1;37m"
read msgg
                                echo -e "\033[1;31m[\033[1;32m01\033[1;31m] >\033[1;34m AZUL"
				echo -e "\033[1;31m[\033[1;32m02\033[1;31m] >\033[1;32m VERDE"
				echo -e "\033[1;31m[\033[1;32m03\033[1;31m] >\033[1;31m ROJO"
				echo -e "\033[1;31m[\033[1;32m04\033[1;31m] >\033[1;33m AMARILLO"
				echo -e "\033[1;31m[\033[1;32m05\033[1;31m] >\033[1;35m ROSA"
				echo -e "\033[1;31m[\033[1;32m06\033[1;31m] >\033[1;36m CYANO"
				echo -e "\033[1;31m[\033[1;32m07\033[1;31m] >\033[0;33m NARANJA"
				echo -e "\033[1;31m[\033[1;32m08\033[1;31m] >\033[1;35m PURPURA"
				echo -e "\033[1;31m[\033[1;32m09\033[1;31m] >\033[30m NEGRO"
				echo -e "\033[1;31m[\033[1;32m10\033[1;31m] >\033[0m SIN COLOR"
				echo ""
				echo -ne "\033[1;33mQUE COLOR\033[1;32m ?\033[1;37m : "
				read sts_cor
				if [[ "$sts_cor" = "1" ]] || [[ "$sts_cor" = "01" ]]; then
					cor_sts='blue'
				elif [[ "$sts_cor" = "2" ]] || [[ "$sts_cor" = "02" ]]; then
					cor_sts='green'
				elif [[ "$sts_cor" = "3" ]] || [[ "$sts_cor" = "03" ]]; then
					cor_sts='red'
				elif [[ "$sts_cor" = "4" ]] || [[ "$sts_cor" = "04" ]]; then
					cor_sts='yellow'
				elif [[ "$sts_cor" = "5" ]] || [[ "$sts_cor" = "05" ]]; then
					cor_sts='#F535AA'
				elif [[ "$sts_cor" = "6" ]] || [[ "$sts_cor" = "06" ]]; then
					cor_sts='cyan'
				elif [[ "$sts_cor" = "7" ]] || [[ "$sts_cor" = "07" ]]; then
					cor_sts='#FF7F00'
				elif [[ "$sts_cor" = "8" ]] || [[ "$sts_cor" = "08" ]]; then
					cor_sts='#9932CD'
				elif [[ "$sts_cor" = "9" ]] || [[ "$sts_cor" = "09" ]]; then
					cor_sts='black'
				elif [[ "$sts_cor" = "10" ]]; then
					cor_sts='null'
				else
					echo -e "\n\033[1;31mOPCION INVALIDA !"
					cor_sts='null'
				fi
msgsocks2=$(cat /etc/ger-inst/PDirect.py | grep "MSG =" | awk -F = '{print $2}')
sed -i "s/$msgsocks2/ '$msgg'/g" /etc/ger-inst/PDirect.py
sleep 1
cor_old=$(grep 'color=' /etc/ger-inst/PDirect.py | cut -d '"' -f2)
sed -i "s/\b$cor_old\b/$cor_sts/g" /etc/ger-inst/PDirect.py
echo -e "\033[1;33mALTERANDO STATUS!"
echo ""
echo -e "\033[1;36mREINICIANDO PROXY SOCKSPYTHON!"
echo ""
if ps x | grep PDirect.py | grep -v grep 1>/dev/null 2>/dev/null; then
echo -e "$(netstat -nplt | grep 'python' | awk {'print $4'} | cut -d: -f2 | xargs)" >/tmp/Pt_sks
for pidproxy in $(screen -ls | grep ".proxy" | awk {'print $1'}); do
screen -r -S "$pidproxy" -X quit
done
screen -wipe >/dev/null
_Ptsks="$(cat /tmp/Pt_sks)"
sleep 1
screen -dmS proxy python /etc/ger-inst/PDirect.py $_Ptsks
rm /tmp/Pt_sks
fi
echo -e "\033[1;32mSTATUS ALTERADO CON EXITO!"
sleep 2
}

echo -e "${barra}"
echo -e "${Rojo} ${cyan}       ESTADO DE CONEXIÓN ${green}[NEW-ADM-PLUS]     ${plain}"
echo -e "${barra}"
echo -e "${num1} ${cyan} ALTERAR ESTADO DE CONEXIÓN  ${plain}"
echo -e "${num0} SALIR"
echo -e "${barra}"
#echo -e "${blue}SELECIONE UNA OPCIÓN: 》 ${yellow}"; read multiscripts
read -p "SELECIONE UNA OPCIÓN: 》" multiscripts
case $multiscripts in
0)
clear
exit;;
1)cambiar_status;;
*)echo -e "${red}¡POR FAVOR SELECIONE EL NÚMERO CORRECTO! ${plain}"
exit ;;
esac
