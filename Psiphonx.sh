#!/bin/bash
fun_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}
fun_ip
rm -rf openssl-1.0.2l.tar.gz openssl-1.0.2l psiphonx.sh
echo -e "\e[1;37m"
echo " INICIANDO LA INSTALACION"
sudo apt-get install python-pip
sudo apt-get install libz-dev
wget https://www.openssl.org/source/openssl-1.0.2l.tar.gz
tar -xvzf openssl-1.0.2l.tar.gz
cd openssl-1.0.2l/
./configure
make
make test
make install
sudo apt-get install libssl-dev
sleep 2s
wget https://raw.githubusercontent.com/Psiphon-Labs/psiphon-tunnel-core-binaries/master/psiphond/psiphond
chmod +x psiphond
sleep 3s
./psiphond --ipaddress 0.0.0.0 --web 8625 --protocol SSH:3001 --protocol OSSH:3002 --protocol FRONTED-MEEK-OSSH:443 generate
sleep 4s
chmod +x psiphond.config
chmod +x psiphond-traffic-rules.config
chmod +x psiphond-osl.config
chmod +x psiphond-tactics.config
chmod +x server-entry.dat/
sleep 5s
echo "INSTALADO CON EXITO"
rm -rf openssl-1.0.2l.tar.gz
