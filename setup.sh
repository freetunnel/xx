#!/bin/bash
repo="https://raw.githubusercontent.com/Freetunnel/hpp/main/"
repo2="https://raw.githubusercontent.com/Freetunnel/xx/main/"

function CEKIP () {
  ipsaya=$(wget -qO- ifconfig.me)
  MYIP=$(curl -sS ipv4.icanhazip.com)
  IPVPS=$(curl -sS https://raw.githubusercontent.com/freetunnel/iz/main/ip | grep $MYIP | awk '{print $4}')
  if [[ $MYIP == $IPVPS ]]; then
    domain
    FTP2
  else
    domain
    FTP2
  fi
}

clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
BIBlue='\033[1;94m'
BGCOLOR='\e[1;97;101m'
tyblue='\e[1;36m'
NC='\e[0m'

cd /root
if [ "${EUID}" -ne 0 ]; then
  echo "You need to run this script as root"
  exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
  echo "OpenVZ is not supported"
  exit 1
fi

localip=$(hostname -I | cut -d\  -f1)
hst=( `hostname` )
dart=$(cat /etc/hosts | grep -w `hostname` | awk '{print $2}')
if [[ "$hst" != "$dart" ]]; then
  echo "$localip $(hostname)" >> /etc/hosts
fi

secs_to_human() {
  echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}

rm -rf /etc/rmbl
mkdir -p /etc/rmbl/theme
mkdir -p /var/lib/ >/dev/null 2>&1
echo "IP=" >> /var/lib/ipvps.conf
clear

echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ ${BGCOLOR}             MASUKKAN NAMA KAMU         ${NC}${BIBlue} │${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo " "
until [[ $name =~ ^[a-zA-Z0-9_.-]+$ ]]; do
  read -rp "Masukan Nama Kamu Disini tanpa spasi : " -e name
done
rm -rf /etc/profil
echo "$name" > /etc/profil
clear

author=$(cat /etc/profil)

# ==== DOMAIN SETUP ====
function domain(){
fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "  \033[0;33mUpdate Domain.. \033[1;37m- \033[0;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[0;32m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[0;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  \033[0;33mUpdate Domain... \033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m Succes !\033[1;37m"
    tput cnorm
}
res1() {
wget ${repo}install/ftp.sh&& chmod +x ftp.sh&& ./ftp.sh
clear
}
clear
cd
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ \033[1;37mPlease select a your Choice to Set Domain${BIBlue}│${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│  [ 1 ]  \033[1;37mDomain kamu sendiri       ${NC}"
echo -e "${BIBlue}│  [ 2 ]  \033[1;37mDomain yang punya script  ${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
until [[ $domain =~ ^[132]+$ ]]; do 
read -p "   Please select numbers 1  atau 2 : " domain
done
if [[ $domain == "1" ]]; then
clear
echo -e  "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e  "${BIBlue}│              \033[1;37mTERIMA KASIH                ${BIBlue}│${NC}"
echo -e  "${BIBlue}│         \033[1;37mSUDAH MENGGUNAKAN SCRIPT         ${BIBlue}│${NC}"
echo -e  "${BIBlue}│                \033[1;37m TUNNEL STORES                 ${BIBlue}│${NC}"
echo -e  "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo " "
until [[ $dnss =~ ^[a-zA-Z0-9_.-]+$ ]]; do 
read -rp "Masukan domain kamu Disini : " -e dnss
done
rm -rf /etc/xray
rm -rf /etc/v2ray
rm -rf /etc/nsdomain
rm -rf /etc/per
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/nsdomain
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/slwdomain
touch /etc/v2ray/scdomain
echo "$dnss" > /root/domain
echo "$dnss" > /root/scdomain
echo "$dnss" > /etc/xray/scdomain
echo "$dnss" > /etc/v2ray/scdomain
echo "$dnss" > /etc/xray/domain
echo "$dnss" > /etc/v2ray/domain
echo "IP=$dnss" > /var/lib/ipvps.conf
echo ""
cd
sleep 1
clear
rm /root/subdomainx
clear
fi
if [[ $domain == "2" ]]; then
clear
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ \033[1;37mPlease select a your Choice to Set Domain${BIBlue}│${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│  [ 1 ]  \033[1;37mDomain xxx.freetinnel.net         ${NC}"                                        
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
until [[ $domain2 =~ ^[1-5]+$ ]]; do 
read -p "   Please select numbers 1 sampai 1 : " domain2
done
fi
if [[ $domain2 == "1" ]]; then
clear
echo -e  "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e  "${BIBlue}│  \033[1;37mContoh subdomain xxx.freetinnel.net       ${BIBlue}│${NC}"
echo -e  "${BIBlue}│    \033[1;37mxxx jadi subdomain kamu               ${BIBlue}│${NC}"
echo -e  "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo " "
until [[ $dn1 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
read -rp "Masukan subdomain kamu Disini tanpa spasi : " -e dn1
done
rm -rf /etc/xray
rm -rf /etc/v2ray
rm -rf /etc/nsdomain
rm -rf /etc/per
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/nsdomain
mkdir -p /etc/per
touch /etc/per/id
touch /etc/per/token
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/slwdomain
touch /etc/v2ray/scdomain
echo "$dn1" > /root/subdomainx
cd
sleep 1
fun_bar 'res1'
clear
rm /root/subdomainx
fi

}

# ==== THEME WARNA ====
cat <<EOF>> /etc/rmbl/theme/green
BG : \E[40;1;42m
TEXT : \033[0;32m
EOF
cat <<EOF>> /etc/rmbl/theme/yellow
BG : \E[40;1;43m
TEXT : \033[0;33m
EOF
cat <<EOF>> /etc/rmbl/theme/red
BG : \E[40;1;41m
TEXT : \033[0;31m
EOF
cat <<EOF>> /etc/rmbl/theme/blue
BG : \E[40;1;44m
TEXT : \033[0;34m
EOF
cat <<EOF>> /etc/rmbl/theme/magenta
BG : \E[40;1;45m
TEXT : \033[0;35m
EOF
cat <<EOF>> /etc/rmbl/theme/cyan
BG : \E[40;1;46m
TEXT : \033[0;36m
EOF
cat <<EOF>> /etc/rmbl/theme/lightgray
BG : \E[40;1;47m
TEXT : \033[0;37m
EOF
cat <<EOF>> /etc/rmbl/theme/darkgray
BG : \E[40;1;100m
TEXT : \033[0;90m
EOF
cat <<EOF>> /etc/rmbl/theme/lightred
BG : \E[40;1;101m
TEXT : \033[0;91m
EOF
cat <<EOF>> /etc/rmbl/theme/lightgreen
BG : \E[40;1;102m
TEXT : \033[0;92m
EOF
cat <<EOF>> /etc/rmbl/theme/lightyellow
BG : \E[40;1;103m
TEXT : \033[0;93m
EOF
cat <<EOF>> /etc/rmbl/theme/lightblue
BG : \E[40;1;104m
TEXT : \033[0;94m
EOF
cat <<EOF>> /etc/rmbl/theme/lightmagenta
BG : \E[40;1;105m
TEXT : \033[0;95m
EOF
cat <<EOF>> /etc/rmbl/theme/lightcyan
BG : \E[40;1;106m
TEXT : \033[0;96m
EOF
cat <<EOF>> /etc/rmbl/theme/color.conf
lightcyan
EOF

# ==== SYSTEM PREP ====
function FTP2(){
  sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
  sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1
  wget ${repo}tools.sh -O tools.sh && chmod +x tools.sh && ./tools.sh
  ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
  apt install git curl python -y >/dev/null 2>&1
}

# ==== INSTALLER MAIN ====
function FTP3(){
  echo -e "${BIBlue}▶ Install SSH & OpenVPN${NC}"
  wget ${repo2}install/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
  clear

  echo -e "${BIBlue}▶ Install Xray${NC}"
  wget ${repo}install/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
  clear

  echo -e "${BIBlue}▶ Install Backup Menu${NC}"
  wget ${repo}install/set-br.sh && chmod +x set-br.sh && ./set-br.sh
  clear

  echo -e "${BIBlue}▶ Install Update Menu${NC}"
  wget ${repo2}update.sh && chmod +x update.sh && ./update.sh
  clear

  echo -e "${BIBlue}▶ Install Limit Xray${NC}"
  wget ${repo}bin/limit.sh && chmod +x limit.sh && ./limit.sh
  clear
}

# ==== DDOS DEF & TORRENT BLOCK ====
function ddos() {
# Instal DDOS Flate
if [ -d '/usr/local/ddos' ]; then
	rm -rf /usr/local/ddos
else
	mkdir /usr/local/ddos
fi
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget --no-check-certificate -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget --no-check-certificate -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget --no-check-certificate -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget --no-check-certificate -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'
}

function torent() {
# blockir torrent & smtp port
iptables -A INPUT -p tcp --dport 25 -j DROP
iptables -A INPUT -p tcp --dport 465 -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables -A FORWARD -m string --algo bm --string "/default.ida?" -j DROP
iptables -A FORWARD -m string --algo bm --string ".exe?/c+dir" -j DROP
iptables -A FORWARD -m string --algo bm --string ".exe?/c_tftp" -j DROP
iptables -A FORWARD -m string --string "peer_id" --algo kmp -j DROP
iptables -A FORWARD -m string --string "BitTorrent" --algo kmp -j DROP
iptables -A FORWARD -m string --string "BitTorrent protocol" --algo kmp -j DROP
iptables -A FORWARD -m string --string "bittorrent-announce" --algo kmp -j DROP
iptables -A FORWARD -m string --string "announce.php?passkey=" --algo kmp -j DROP
iptables -A FORWARD -m string --string "find_node" --algo kmp -j DROP
iptables -A FORWARD -m string --string "info_hash" --algo kmp -j DROP
iptables -A FORWARD -m string --string "get_peers" --algo kmp -j DROP
iptables -A FORWARD -m string --string "announce" --algo kmp -j DROP
iptables -A FORWARD -m string --string "announce_peers" --algo kmp -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
}

function limit(){
cat > /etc/systemd/system/xraylimit.service <<-END
[Unit]
Description=Xray Limit Script Service
ConditionPathExists=/usr/bin/xraylimit

[Service]
Type=simple
ExecStart=/usr/bin/xraylimit
Restart=always
RestartSec=3
TimeoutSec=0
StandardOutput=tty

[Install]
WantedBy=multi-user.target
END
systemctl daemon-reload
systemctl enable xraylimit.service
systemctl start xraylimit.service
}
function iinfo(){
domain=$(cat /etc/xray/domain)
TIMES="10"
CHATID="-1002305290411"
KEY="8093025196:AAHAykxQ3K5TBPNev8ozawCi5pR9N9CpWsE"
URL="https://api.telegram.org/bot$KEY/sendMessage"
ISP=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)
domain=$(cat /etc/xray/domain) 
TIME=$(date '+%d %b %Y')
RAMMS=$(free -m | awk 'NR==2 {print $2}')
MODEL2=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')
MYIP=$(curl -sS ipv4.icanhazip.com)
IZIN=$(curl -sS https://raw.githubusercontent.com/freetunnel/iz/main/ip | grep $MYIP | awk '{print $3}' )
d1=$(date -d "$IZIN" +%s)
d2=$(date -d "$today" +%s)
USRSC=$(wget -qO- https://raw.githubusercontent.com/freetunnel/iz/main/ip | grep $ipsaya | awk '{print $2}')
EXPSC=$(wget -qO- https://raw.githubusercontent.com/freetunnel/iz/main/ip | grep $ipsaya | awk '{print $3}')
TEXT="
<code>⚡───────────────────⚡</code>
<b> INSTALL AUTOSCRIPT PREMIUM</b>
<code>⚡───────────────────⚡</code>
<code>ID    : </code><code>$USRSC</code>
<code>Date  : </code><code>$TIME</code>
<code>Exp   : </code><code>$EXPSC</code>
<code>Name : </code><code>$name</code>
<code>ISP   : </code><code>$ISP</code>
<code>KODE  : </code><code>X-RAY SCRIPT</code>
<code>⚡───────────────────⚡</code>
<i>Automatic Notification Install Script</i>
"'&reply_markup={"inline_keyboard":[[{"text":"ᴏʀᴅᴇʀ","url":"https://t.me/freetunnel3"},{"text":"JOIN","url":"t.me/ftp_corp"}]]}'

curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
clear
}

CEKIP
FTP3
ddos
torent
limit
cat> /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
menu
END
chmod 644 /root/.profile
if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
if [ ! -f "/etc/log-create-user.log" ]; then
echo "Log All Account " > /etc/log-create-user.log
fi
history -c
serverV=$( curl -sS ${repo}versi  )
echo $serverV > /opt/.ver
aureb=$(cat /home/re_otm)
b=11
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi
cd
curl -sS ifconfig.me > /etc/myipvps
curl -s ipinfo.io/city?token=75082b4831f909 >> /etc/xray/city
curl -s ipinfo.io/org?token=75082b4831f909  | cut -d " " -f 2-10 >> /etc/xray/isp
rm /root/setup.sh >/dev/null 2>&1
rm /root/slhost.sh >/dev/null 2>&1
rm /root/ssh-vpn.sh >/dev/null 2>&1
rm /root/ins-xray.sh >/dev/null 2>&1
rm /root/insshws.sh >/dev/null 2>&1
rm /root/set-br.sh >/dev/null 2>&1
rm /root/ohp.sh >/dev/null 2>&1
rm /root/update.sh >/dev/null 2>&1
rm /root/slowdns.sh >/dev/null 2>&1
rm -rf /etc/noobz
mkdir -p /etc/noobz
echo "" > /etc/xray/noob
secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
sleep 3
echo  ""
cd
iinfo
rm -rf *
echo -e "${BIBlue}╭════════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ ${BGCOLOR} INSTALL SCRIPT SELESAI..                 ${NC}${BIBlue} │${NC}"
echo -e "${BIBlue}╰════════════════════════════════════════════╯${NC}"
echo  ""
sleep 4
echo -e "[ ${yell}WARNING${NC} ] Do you want to reboot now ? (y/n)? "; read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi
