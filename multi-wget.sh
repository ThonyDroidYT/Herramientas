#!/bin/bash
#18/04/2021
#BY THONYDROID
barra='====================================='
echo -e "\033[1;34m${barra}\033[0m"
echo -e "\e[1;32m Descargador de multi archivos GitHub\e[0m"
echo -e "\033[1;34m${barra}\033[0m"
echo -ne "\e[0m Link de los archivos a descargar: " && read PATCH2
echo -ne "\e[0m Nombre de la carpeta para guardar los archivos: " && read DIRE2
echo -ne "\e[0m Lista de archivos: " && read LISTA2
PATCH=$PATCH2
DIRE="$HOME/${DIRE2}"
LISTA=$LISTA2
[ -z "$LISTA" ]  && LISTA="lista-arq"
[[ ! -d ${DIRE} ]]  && mkdir ${DIRE}
    wget -O ${DIRE}/${LISTA} $PATCH/${LISTA} &> /dev/null
    for arqx in $(cat ${DIRE}/${LISTA}); do
    echo -e "\033[1;33mDescargando Archivo \033[1;35m[$arqx] \033[0m"
    wget -O ${DIRE}/$arqx ${PATCH}/$arqx &> /dev/null
    done
#if [[ -e "${DIRE}/$arqx" ]]; then
#echo -e "\e[1;32mArchivo $arqx descargado con éxito\033[0m"
#else
#echo -e "\033[1;31mFalla al descargar Archivo $arqx\033[0m"
#fi
echo -e "\033[1;32mDescarga Finalizada!\033[0m"