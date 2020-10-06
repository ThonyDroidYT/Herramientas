#!/usr/bin/env bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

cur_dir=$(pwd)

# check root
[[ $EUID -ne 0 ]] && echo -e "${red}错误：${plain} 必须使用root用户运行此脚本！\n" && exit 1

# check os
if [[ -f /etc/redhat-release ]]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    echo -e "${red}未检测到系统版本，请联系脚本作者！${plain}\n" && exit 1
fi

if [ $(getconf WORD_BIT) != '32' ] && [ $(getconf LONG_BIT) != '64' ] ; then
    echo "本软件不支持 32 位系统(x86)，请使用 64 位系统(x86_64)，如果检测有误，请联系作者"
    exit -1
fi

os_version=""

# os version
if [[ -f /etc/os-release ]]; then
    os_version=$(awk -F'[= ."]' '/VERSION_ID/{print $3}' /etc/os-release)
fi
if [[ -z "$os_version" && -f /etc/lsb-release ]]; then
    os_version=$(awk -F'[= ."]+' '/DISTRIB_RELEASE/{print $2}' /etc/lsb-release)
fi

if [[ x"${release}" == x"centos" ]]; then
    if [[ ${os_version} -le 6 ]]; then
        echo -e "${red}请使用 CentOS 7 或更高版本的系统！${plain}\n" && exit 1
    fi
elif [[ x"${release}" == x"ubuntu" ]]; then
    if [[ ${os_version} -lt 16 ]]; then
        echo -e "${red}请使用 Ubuntu 16 或更高版本的系统！${plain}\n" && exit 1
    fi
elif [[ x"${release}" == x"debian" ]]; then
    if [[ ${os_version} -lt 8 ]]; then
        echo -e "${red}请使用 Debian 8 或更高版本的系统！${plain}\n" && exit 1
    fi
fi

confirm() {
    if [[ $# > 1 ]]; then
        echo && read -p "$1 [默认$2]: " temp
        if [[ x"${temp}" == x"" ]]; then
            temp=$2
        fi
    else
        read -p "$1 [y/n]: " temp
    fi
    if [[ x"${temp}" == x"y" || x"${temp}" == x"Y" ]]; then
        return 0
    else
        return 1
    fi
}

install_base() {
    if [[ x"${release}" == x"centos" ]]; then
        yum install wget curl tar unzip -y
    else
        apt install wget curl tar unzip -y
    fi
}

uninstall_old_v2ray() {
    if [[ -f /usr/bin/v2ray/v2ray ]]; then
        confirm "检测到旧版 v2ray，是否卸载，将删除 /usr/bin/v2ray/ 与 /etc/systemd/system/v2ray.service" "Y"
        if [[ $? != 0 ]]; then
            echo "不卸载则无法安装 v2-ui"
            exit 1
        fi
        echo -e "${green}卸载旧版 v2ray${plain}"
        systemctl stop v2ray
        rm /usr/bin/v2ray/ -rf
        rm /etc/systemd/system/v2ray.service -f
        systemctl daemon-reload
    fi
    if [[ -f /usr/local/bin/v2ray ]]; then
        confirm "检测到其它方式安装的 v2ray，是否卸载，v2-ui 自带官方 v2ray 内核，为防止与其端口冲突，建议卸载" "Y"
        if [[ $? != 0 ]]; then
            echo -e "${red}你选择了不卸载，请自行确保其它脚本安装的 v2ray 与 v2-ui ${green}自带的官方 v2ray 内核${red}不会端口冲突${plain}"
        else
            echo -e "${green}开始卸载其它方式安装的 v2ray${plain}"
            systemctl stop v2ray
            bash <(curl https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh) --remove
            systemctl daemon-reload
        fi
    fi
}

install_v2ray() {
    uninstall_old_v2ray
    echo -e "${green}开始安装or升级v2ray${plain}"
    bash <(curl https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)
    if [[ $? -ne 0 ]]; then
        echo -e "${red}v2ray安装或升级失败，请检查错误信息${plain}"
        echo -e "${yellow}大多数原因可能是因为你当前服务器所在的地区无法下载 v2ray 安装包导致的，这在国内的机器上较常见，解决方式是手动安装 v2ray，具体原因还是请看上面的错误信息${plain}"
        exit 1
    fi
    echo "
[Unit]
Description=V2Ray Service
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
Environment=V2RAY_LOCATION_ASSET=/usr/local/share/v2ray/
ExecStart=/usr/local/bin/v2ray -confdir /usr/local/etc/v2ray/
Restart=on-failure

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/v2ray.service
    if [[ ! -f /usr/local/etc/v2ray/00_log.json ]]; then
        echo "{}" > /usr/local/etc/v2ray/00_log.json
    fi
    if [[ ! -f /usr/local/etc/v2ray/01_api.json ]]; then
        echo "{}" > /usr/local/etc/v2ray/01_api.json
    fi
    if [[ ! -f /usr/local/etc/v2ray/02_dns.json ]]; then
        echo "{}" > /usr/local/etc/v2ray/02_dns.json
    fi
    if [[ ! -f /usr/local/etc/v2ray/03_routing.json ]]; then
        echo "{}" > /usr/local/etc/v2ray/03_routing.json
    fi
    if [[ ! -f /usr/local/etc/v2ray/04_policy.json ]]; then
        echo "{}" > /usr/local/etc/v2ray/04_policy.json
    fi
    if [[ ! -f /usr/local/etc/v2ray/05_inbounds.json ]]; then
        echo "{}" > /usr/local/etc/v2ray/05_inbounds.json
    fi
    if [[ ! -f /usr/local/etc/v2ray/06_outbounds.json ]]; then
        echo "{}" > /usr/local/etc/v2ray/06_outbounds.json
    fi
    if [[ ! -f /usr/local/etc/v2ray/07_transport.json ]]; then
        echo "{}" > /usr/local/etc/v2ray/07_transport.json
    fi
    if [[ ! -f /usr/local/etc/v2ray/08_stats.json ]]; then
        echo "{}" > /usr/local/etc/v2ray/08_stats.json
    fi
    if [[ ! -f /usr/local/etc/v2ray/09_reverse.json ]]; then
        echo "{}" > /usr/local/etc/v2ray/09_reverse.json
    fi
    systemctl daemon-reload
    systemctl enable v2ray
    systemctl start v2ray
}

close_firewall() {
    if [[ x"${release}" == x"centos" ]]; then
        systemctl stop firewalld
        systemctl disable firewalld
    elif [[ x"${release}" == x"ubuntu" ]]; then
        ufw disable
#    elif [[ x"${release}" == x"debian" ]]; then
#        iptables -P INPUT ACCEPT
#        iptables -P OUTPUT ACCEPT
#        iptables -P FORWARD ACCEPT
#        iptables -F
    fi
}

install_v2-ui() {
    systemctl stop v2-ui
    cd /usr/local/
    if [[ -e /usr/local/v2-ui/ ]]; then
        rm /usr/local/v2-ui/ -rf
    fi

    if  [ $# == 0 ] ;then
        last_version=$(curl -Ls "https://api.github.com/repos/sprov065/v2-ui/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
        if [[ ! -n "$last_version" ]]; then
            echo -e "${red}检测 v2-ui 版本失败，可能是超出 Github API 限制，请稍后再试，或手动指定 v2-ui 版本安装${plain}"
            exit 1
        fi
        echo -e "检测到 v2-ui 最新版本：${last_version}，开始安装"
        wget -N --no-check-certificate -O /usr/local/v2-ui-linux.tar.gz https://github.com/sprov065/v2-ui/releases/download/${last_version}/v2-ui-linux.tar.gz
        if [[ $? -ne 0 ]]; then
            echo -e "${red}下载 v2-ui 失败，请确保你的服务器能够下载 Github 的文件${plain}"
            exit 1
        fi
    else
        last_version=$1
        url="https://github.com/sprov065/v2-ui/releases/download/${last_version}/v2-ui-linux.tar.gz"
        echo -e "开始安装 v2-ui v$1"
        wget -N --no-check-certificate -O /usr/local/v2-ui-linux.tar.gz ${url}
        if [[ $? -ne 0 ]]; then
            echo -e "${red}下载 v2-ui v$1 失败，请确保此版本存在${plain}"
            exit 1
        fi
    fi

    tar zxvf v2-ui-linux.tar.gz
    rm v2-ui-linux.tar.gz -f
    cd v2-ui
    chmod +x v2-ui bin/v2ray-v2-ui bin/v2ctl
    cp -f v2-ui.service /etc/systemd/system/
    systemctl daemon-reload
    systemctl enable v2-ui
    systemctl start v2-ui
    echo -e "${green}v2-ui v${last_version}${plain} 安装完成，面板已启动，"
    echo -e ""
    echo -e "Si es una instalación nueva，El puerto web predeterminado es ${green}65432${plain}，El nombre de usuario y la contraseña son ambos predeterminados ${green}admin${plain}"
    echo -e "Asegúrese de que este puerto no esté ocupado por otros programas，${yellow}Y asegúrate 65432 El puerto ha sido liberado${plain}"
    echo -e "Si quieres 65432 Modificar a otros puertos，entrar v2-ui Comando para modificar，También asegúrese de que el puerto que modifica también esté permitido"
    echo -e ""
    echo -e "Si es un panel de actualización，Luego acceda al panel como lo hizo antes"
    echo -e ""
    curl -o /usr/bin/v2-ui -Ls https://raw.githubusercontent.com/sprov065/v2-ui/master/v2-ui.sh
    chmod +x /usr/bin/v2-ui
    echo -e "v2-ui Cómo usar scripts de administración:"
    echo -e "----------------------------------------------"
    echo -e "v2-ui              - Mostrar menú de gestión (Más funciones)"
    echo -e "v2-ui start        - Poner en marcha v2-ui panel"
    echo -e "v2-ui stop         - Detener v2-ui panel"
    echo -e "v2-ui restart      - Reiniciar v2-ui panel
    echo -e "v2-ui status       - Ver v2-ui estado"
    echo -e "v2-ui enable       - Preparar v2-ui Autoinicio"
    echo -e "v2-ui disable      - cancelar v2-ui Autoinicio"
    echo -e "v2-ui log          - Ver v2-ui Registro"
    echo -e "v2-ui update       - Actualizar v2-ui panel"
    echo -e "v2-ui install      - Instalar v2-ui panel"
    echo -e "v2-ui uninstall    - Desinstalar v2-ui panel"
    echo -e "----------------------------------------------"
}

echo -e "${green}开始安装${plain}"
install_base
uninstall_old_v2ray
close_firewall
install_v2-ui $1
