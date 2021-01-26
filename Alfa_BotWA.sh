#!/bin/bash
#25/01/2021
#Hecho By: @Thony_DroidYT

fun_bar () {
comando="$1"
 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
echo -ne " \033[1;33m["
   for((i=0; i<10; i++)); do
   echo -ne "\033[1;31m##"
   sleep 0.2
   done
echo -ne "\033[1;33m]"
sleep 1s
echo
tput cuu1
tput dl1
done
echo -e " \033[1;33m[\033[1;31m####################\033[1;33m] - \033[1;32m100%\033[0m"
sleep 1s
}
instalar_paquetes () {
echo -e "\033[1;33miniciando instalación\033[0m"
fun_bar
pkg update; pkg upgrade
pkg install git
pkg install tesseract
pkg install nodejs
pkg install libwebp
pkg install ffmpeg
pkg install wget
echo -e "\033[1;32mInstalación Terminada\033[0m"
fun_bar
echo -e "\033[1;33mClonando Repositorio\033[0m"
fun_bar
git clone https://github.com/HigorOlive/Dkxin
cd $HOME
cd Dkxin
echo -e "\033[1;32mIniciando Bot\033[0m"
fun_bar
npm install
npm start
}
instalar_paquetes
