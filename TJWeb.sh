#!/bin/bash
#04/11/2020
#Hecho BY @Thony_DroidYT
# fonts color
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[1;32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
blue(){
    echo -e "\033[1;34m\033[01m$1\033[0m"
}
bold(){
    echo -e "\033[1m\033[01m$1\033[0m"
}
cyan(){
    echo -e "\033[1;36m\033[01m$1\033[0m"
}


configTrojanWebPath="${HOME}/trojan-web"
versionTrojanWeb="2.8.7"
downloadFilenameTrojanWeb="trojan"
configTrojanWebNginxPath=$(cat /dev/urandom | head -1 | md5sum | head -c 5)
configTrojanWebPort="$(($RANDOM + 10000))"

function setLinuxDateZone(){

    tempCurrentDateZone=$(date +'%z')

    if [[ ${tempCurrentDateZone} == "+0800" ]]; then
        yellow "当前时区已经为北京时间  $tempCurrentDateZone | $(date -R) "
    else 
        blue " =================================================="
        yellow "当前时区为: $tempCurrentDateZone | $(date -R) "
        yellow "是否设置时区为北京时间 +0800区, 以便cron定时重启脚本按照北京时间运行."
        blue " =================================================="
        # read 默认值 https://stackoverflow.com/questions/2642585/read-a-variable-in-bash-with-a-default-value

        read -p "是否设置为北京时间 +0800 时区? 请输入[Y/n]?" osTimezoneInput
        osTimezoneInput=${osTimezoneInput:-Y}

        if [[ $osTimezoneInput == [Yy] ]]; then
            if [[ -f /etc/localtime ]] && [[ -f /usr/share/zoneinfo/Asia/Shanghai ]];  then
                mv /etc/localtime /etc/localtime.bak
                cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

                yellow "设置成功! 当前时区已设置为 $(date -R)"
                blue " =================================================="
            fi
        fi

    fi
}

function removeNginx(){

    sudo systemctl stop nginx.service

    blue " ================================================== "
    red " 准备卸载已安装的nginx"
    blue " ================================================== "

    if [ "$osRelease" == "centos" ]; then
        yum remove -y nginx
    else
        apt autoremove -y --purge nginx nginx-common nginx-core
        apt-get remove --purge nginx nginx-full nginx-common
    fi

    rm -rf ${configSSLCertPath}
    rm -rf ${configWebsitePath}
    rm -f ${nginxAccessLogFilePath}
    rm -f ${nginxErrorLogFilePath}

    rm -rf "/etc/nginx"
    rm -rf /root/.acme.sh/
    rm -rf ${configDownloadTempPath}

    blue " ================================================== "
    cyan "  Nginx 卸载完毕 !"
    blue " ================================================== "
}

function installTrojanWeb(){
    # wget -O trojan-web_install.sh -N --no-check-certificate "https://raw.githubusercontent.com/Jrohy/trojan/master/install.sh" && chmod +x trojan-web_install.sh && ./trojan-web_install.sh


    if [ -f "${configTrojanWebPath}/trojan-web" ] ; then
        blue " =================================================="
        cyan "  已安装过 Trojan-web 可视化管理面板, 退出安装 !"
        blue " =================================================="
        exit
    fi

    stopServiceNginx
    testLinuxPortUsage

    blue " ================================================== "
    cyan " 请输入绑定到本VPS的域名 例如www.xxx.com: (此步骤请关闭CDN后安装)"
    blue " ================================================== "

    read configSSLDomain
    if compareRealIpWithLocalIp "${configSSLDomain}" ; then

        getTrojanAndV2rayVersion "trojan-web"
        blue " =================================================="
        cyan "    开始安装 Trojan-web 可视化管理面板: ${versionTrojanWeb} !"
        blue " =================================================="

        mkdir -p ${configTrojanWebPath}
        wget -O ${configTrojanWebPath}/trojan-web --no-check-certificate "https://github.com/Jrohy/trojan/releases/download/v${versionTrojanWeb}/${downloadFilenameTrojanWeb}"
        chmod +x ${configTrojanWebPath}/trojan-web

        # 增加启动脚本
        cat > ${osSystemMdPath}trojan-web.service <<-EOF
[Unit]
Description=trojan-web
Documentation=https://github.com/Jrohy/trojan
After=network.target network-online.target nss-lookup.target mysql.service mariadb.service mysqld.service docker.service

[Service]
Type=simple
StandardError=journal
ExecStart=${configTrojanWebPath}/trojan-web web -p ${configTrojanWebPort}
ExecReload=/bin/kill -HUP \$MAINPID
Restart=on-failure
RestartSec=3s

[Install]
WantedBy=multi-user.target
EOF

        sudo systemctl daemon-reload
        sudo systemctl restart trojan-web.service
        sudo systemctl enable trojan-web.service

        blue " =================================================="
        cyan " Trojan-web 可视化管理面板: ${versionTrojanWeb} 安装成功!"
        cyan " Trojan可视化管理面板地址 https://${configSSLDomain}/${configTrojanWebNginxPath}"
        cyan " 开始运行命令 ${configTrojanWebPath}/trojan-web 进行初始化设置."
        blue " =================================================="



        ${configTrojanWebPath}/trojan-web

        installWebServerNginx "trojan-web"

        # 命令补全环境变量
        echo "export PATH=$PATH:${configTrojanWebPath}" >> ${HOME}/.${osSystemShell}rc

        # (crontab -l ; echo '25 0 * * * "/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" > /dev/null') | sort - | uniq - | crontab -
        (crontab -l ; echo "30 4 * * 0,1,2,3,4,5,6 systemctl restart trojan-web.service") | sort - | uniq - | crontab -

    else
        exit
    fi
}

function removeTrojanWeb(){
    # wget -O trojan-web_install.sh -N --no-check-certificate "https://raw.githubusercontent.com/Jrohy/trojan/master/install.sh" && chmod +x trojan-web_install.sh && ./trojan-web_install.sh --remove

    blue " ================================================== "
    red " 准备卸载已安装 Trojan-web "
    blue " ================================================== "

    sudo systemctl stop trojan.service
    sudo systemctl stop trojan-web.service
    sudo systemctl disable trojan-web.service

    # 移除trojan web 管理程序  和数据库 leveldb文件
    # rm -f /usr/local/bin/trojan
    rm -rf ${configTrojanWebPath}
    rm -f ${osSystemMdPath}trojan-web.service
    rm -rf /var/lib/trojan-manager

    # 移除trojan
    rm -rf /usr/bin/trojan
    rm -rf /usr/local/etc/trojan
    rm -f ${osSystemMdPath}trojan.service

    # 移除trojan的专用数据库
    docker rm -f trojan-mysql
    docker rm -f trojan-mariadb
    rm -rf /home/mysql
    rm -rf /home/mariadb


    # 移除环境变量
    sed -i '/trojan/d' ${HOME}/.${osSystemShell}rc

    crontab -r

    blue " ================================================== "
    cyan "  Trojan-web 卸载完毕 !"
    blue " ================================================== "
}

function upgradeTrojanWeb(){
    getTrojanAndV2rayVersion "trojan-web"
    blue " =================================================="
    cyan "    开始升级 Trojan-web 可视化管理面板: ${versionTrojanWeb} !"
    blue " =================================================="

    sudo systemctl stop trojan-web.service

    mkdir -p ${configDownloadTempPath}/upgrade/trojan-web

    wget -O ${configDownloadTempPath}/upgrade/trojan-web/trojan-web "https://github.com/Jrohy/trojan/releases/download/v${versionTrojanWeb}/${downloadFilenameTrojanWeb}"
    mv -f ${configDownloadTempPath}/upgrade/trojan-web/trojan-web ${configTrojanWebPath}
    chmod +x ${configTrojanWebPath}/trojan-web

    sudo systemctl start trojan-web.service
    sudo systemctl restart trojan.service

    blue " ========================================================="
    cyan "     升级成功 Trojan-web 可视化管理面板: ${versionTrojanWeb} !"
    blue " ========================================================="
}
function runTrojanWebSSL(){
    sudo systemctl stop trojan-web.service
    sudo systemctl stop nginx.service
    sudo systemctl stop trojan.service
    ${configTrojanWebPath}/trojan-web tls
    sudo systemctl start trojan-web.service
    sudo systemctl start nginx.service
    sudo systemctl restart trojan.service
}
function runTrojanWebLog(){
    ${configTrojanWebPath}/trojan-web
}

    blue " ========================================================="
    green " [1]. \033[1;31m> \033[1;36m安装 trojan-web (trojan 和 trojan-go 可视化管理面板) 和 nginx 伪装网站"
    blue " ========================================================="
    green " [2]. \033[1;31m> \033[1;36m升级 trojan-web 到最新版本"
    blue " ========================================================="
    gren " [3]. \033[1;31m> \033[1;36m重新申请证书"
    blue " ========================================================="
    green " [4]. \033[1;31m> \033[1;36m查看日志, 管理用户, 查看配置等功能"
    blue " ========================================================="
    greeb " [5]. \033[1;31m> \033[1;36m卸载 trojan-web 和 nginx "
    blue " ========================================================="
    green " [0]. \033[1;31m> \033[1;36mSalir"
    blue " ========================================================="
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
            setLinuxDateZone
            installTrojanWeb
        ;;
        2 )
            upgradeTrojanWeb
        ;;
        3 )
            runTrojanWebSSL
        ;;

        4 )
            runTrojanWebLog
        ;;
        5 )
            removeNginx
            removeTrojanWeb
        ;;
        0 )
            exit 1
        ;;
        * )
            clear
            red "请输入正确数字 !"
            sleep 2s
            start_menu
        ;;
    esac
}
