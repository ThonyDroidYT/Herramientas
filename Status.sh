#!/bin/bash
fun_bar() {
		comando[0]="$1"
		comando[1]="$2"
		(
			[[ -e $HOME/fim ]] && rm $HOME/fim
		 #[[ ! -d /etc/SSHPlus ]] && rm -rf /bin/menu
			${comando[0]} >/dev/null 2>&1
			${comando[1]} >/dev/null 2>&1
			touch $HOME/fim
		) >/dev/null 2>&1 &
		tput civis
		echo -ne "\033[1;33mESPERE \033[1;37m- \033[1;33m["
		while true; do
			for ((i = 0; i < 18; i++)); do
				echo -ne "\033[1;31m#"
				sleep 0.1s
			done
			[[ -e $HOME/fim ]] && rm $HOME/fim && break
			echo -e "\033[1;33m]"
			sleep 1s
			tput cuu1
			tput dl1
			echo -ne "\033[1;33mESPERE \033[1;37m- \033[1;33m["
		done
		echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
		tput cnorm
	}

cambiar_status () {
msgsocks=$(cat /etc/ger-inst/PDirect.py | grep -E "MSG =" | awk -F = '{print $2}' | cut -d "'" -f 2)
				echo -e "\E[44;1;37m             PROXY SOCKS              \E[0m"
				echo ""
				echo -e "\033[1;33mSTATUS: \033[1;32m$msgsocks"
				echo""
				echo -ne "\033[1;32mINFORME SU STATUS\033[1;31m:\033[1;37m "
				read msgg
				colores
				[[ -z "$msgg" ]] && {
					echo -e "\n\033[1;31mStatus invalido!"
					sleep 2
					status
				}
	                [[ ${msgg} != ?(+|-)+([a-zA-Z0-9-. ]) ]] && {
					echo -e "\n\033[1;31m[\033[1;33m!\033[1;31m]\033[1;33m EVITE CARACTERES ESPECIALES\033[0m"
					sleep 2
					status
				}
fun_msgsocks() {
					msgsocks2=$(cat /etc/ger-inst/PDirect.py | grep "MSG =" | awk -F = '{print $2}')
					sed -i "s/$msgsocks2/ '$msgg'/g" /etc/ger-inst/PDirect.py
					sleep 1
					cor_old=$(grep 'color=' /etc/ger-inst/PDirect.py | cut -d '"' -f2)
					sed -i "s/\b$cor_old\b/$cor_sts/g" /etc/ger-inst/PDirect.py
					alterando2
}
alterando2 () {
echo -e "\033[1;32mREINICIANDO PROXY SOCKS!"
				echo ""
				fun_bar 'restartsocks'
				echo ""
				echo -e "\033[1;32mSTATUS ALTERADO CON EXITO!"
				sleep 2
				status
}

alterando () {
echo -e "\033[1;32mALTERANDO STATUS!"
				echo ""
				fun_bar 'fun_msgsocks'
}
				restartsocks() {
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
						alterando2
					fi
				}
colores () {
echo -e "\n\033[1;31m[\033[1;36m01\033[1;31m]\033[1;34m AZUL"
				echo -e "\033[1;31m[\033[1;36m02\033[1;31m]\033[1;32m VERDE"
				echo -e "\033[1;31m[\033[1;36m03\033[1;31m]\033[1;31m ROJO"
				echo -e "\033[1;31m[\033[1;36m04\033[1;31m]\033[1;33m AMARILLO"
				echo -e "\033[1;31m[\033[1;36m05\033[1;31m]\033[1;35m ROSA"
				echo -e "\033[1;31m[\033[1;36m06\033[1;31m]\033[1;36m CYANO"
				echo -e "\033[1;31m[\033[1;36m07\033[1;31m]\033[1;33m NARANJA"
				echo -e "\033[1;31m[\033[1;36m08\033[1;31m]\033[1;35m PURPURA"
				echo -e "\033[1;31m[\033[1;36m09\033[1;31m]\033[1;33m NEGRO"
				echo -e "\033[1;31m[\033[1;36m10\033[1;31m]\033[0m SIN COLOR"
				echo ""
				echo -ne "\033[1;32mQUE COLOR\033[1;31m ?\033[1;37m : "
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
					echo -e "\n\033[1;33mOPCION INVALIDA !"
					cor_sts='null'
                    alterando
				fi
}
status () {
echo -e "\033[1;33mCambiar el Estado de Conexión Python Directo\033[1;32m\033[0m"
#while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
#read -p "[S/N]: " yesno
#tput cuu1 && tput dl1
#done
#if [[ ${yesno} = @(s|S|y|Y) ]]; then
cambiar_status
#fi
}
cambiar_status
