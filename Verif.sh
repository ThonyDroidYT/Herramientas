104.238.135.147
L_verif="https://git.io"
vo=$(curl -sSL "${L_verif}/unlockadm")
vp=$(cat /usr/bin/vendor_code)

[[ ! "$(echo $vo|grep ${vp})" ]] && {
msg -bar
echo -e "\033[1;31m $(source trans -b pt:${id} "Que Verguenza! Su versión es Pirata!")\033[0m"
msg -bar
echo -e "\033[1;31m $(source trans -b pt:${id} "Use ADM-PLUS Original")\033[0m"
echo -e "${cor[3]} $(source trans -b pt:${id} "Ayude a Quien Realmente desarrolla y se Dedica al Projeto!")\033[0m"
msg -bar
rm -rf ${SCPdir} &>/dev/null
rm -rf ${SCPusr} &>/dev/null
rm -rf ${SCPfrm} &>/dev/null
rm -rf ${SCPinst} &>/dev/null
rm -rf ${SCPfrm} &>/dev/null
rm -rf ${SCPidioma} &>/dev/null
exit 0
}
