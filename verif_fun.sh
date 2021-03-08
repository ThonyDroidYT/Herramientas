#!bin/bash
[[ ! "$(echo $vo|grep $(cat /usr/bin/vendor_code))" ]] && {
echo -e "\033[1;31m $(fun_trans "Que Verguenza! Su versión es Pirata")!\033[0m"
echo -e""
echo -e "\033[1;31m $(fun_trans "Use ADM-PLUS Original")\033[0m"
echo -e "\033[1;31m $(fun_trans "Ayude a Quien Realmente desarrolla y se Dedica al Projeto")!\033[0m"
rm -rf ${SCPdir} &>/dev/null
rm -rf ${SCPusr} &>/dev/null
rm -rf ${SCPfrm} &>/dev/null
rm -rf ${SCPinst} &>/dev/null
rm -rf ${SCPfrm} &>/dev/null
rm -rf ${SCPidioma} &>/dev/null
exit 0
}

#verif 2
verif_fun2 () {
vo=$(curl -sSL "${P_SERVER}/unlockadm")
vo2=$(wget -qO- https://git.io/unlockadm)
vp=$(cat /usr/bin/vendor_code)
[[ $vo = $vp ]] && menu || exit 0
}

#verif 3
verif_fun3 () {
vo=$(curl -sSL "${P_SERVER}/unlockadm")
vo2=$(wget -qO- https://git.io/unlockadm)
vp=$(cat /usr/bin/vendor_code)
####
[[ $vo = $vp ]] && menu || exit 0
echo -e "\033[1;31m $(fun_trans "Que Verguenza! Su versión es Pirata")!\033[0m"
echo -e""
echo -e "\033[1;31m $(fun_trans "Use ADM-PLUS Original")\033[0m"
echo -e "\033[1;31m $(fun_trans "Ayude a Quien Realmente desarrolla y se Dedica al Projeto")!\033[0m"
rm -rf ${SCPdir} &>/dev/null
rm -rf ${SCPusr} &>/dev/null
rm -rf ${SCPfrm} &>/dev/null
rm -rf ${SCPinst} &>/dev/null
rm -rf ${SCPfrm} &>/dev/null
rm -rf ${SCPidioma} &>/dev/null
exit 0
}

#verif 4
verif_fun4 () {
vo=$(curl -sSL "${P_SERVER}/unlockadm")
vo2=$(wget -qO- https://git.io/unlockadm)
vp=$(cat /usr/bin/vendor_code)
####
#[[ $vo = $vp ]] && menu || exit 0
#[[ $vo = $vp ]] && menu || basch <(curl -Ls https://git.io/admpluscrk)
}
