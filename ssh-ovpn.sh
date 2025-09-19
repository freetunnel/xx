#!/bin/bash
#
# ==================================================
# Cleaned installer script (support tools only for Xray)
# ==================================================

repo="https://raw.githubusercontent.com/Freetunnel/hpp/main/"
export DEBIAN_FRONTEND=noninteractive

# Update system & install basic tools
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt-get remove --purge ufw firewalld exim4 -y
apt install -y screen curl jq bzip2 gzip vnstat coreutils rsyslog iftop zip unzip git apt-transport-https build-essential -y
apt -y install wget curl htop neofetch figlet ruby lolcat fail2ban shc

# set timezone
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# rc-local service setup
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

cat > /etc/rc.local <<-END
#!/bin/sh -e
exit 0
END

chmod +x /etc/rc.local
systemctl enable rc-local
systemctl start rc-local.service

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\\necho 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

# install vnstat (latest build)
apt -y install vnstat libsqlite3-dev
/etc/init.d/vnstat restart
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd ..
vnstat -u -i $(ip -o -4 route show to default | awk '{print $5}')
sed -i 's/Interface "eth0"/Interface "$(ip -o -4 route show to default | awk '{print $5}')"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f vnstat-2.6.tar.gz
rm -rf vnstat-2.6

# memory swap 1GB
dd if=/dev/zero of=/swapfile bs=1024 count=1048576
mkswap /swapfile
chown root:root /swapfile
chmod 0600 /swapfile
swapon /swapfile
sed -i '$ i\\/swapfile swap swap defaults 0 0' /etc/fstab

# memory swap 1gb
cd
dd if=/dev/zero of=/swapfile bs=1024 count=1048576
mkswap /swapfile
chown root:root /swapfile
chmod 0600 /swapfile >/dev/null 2>&1
swapon /swapfile >/dev/null 2>&1
sed -i '$ i\/swapfile      swap swap   defaults    0 0' /etc/fstab

# install fail2ban
apt -y install fail2ban

# download script
cd /usr/bin
wget -O issue "${repo}install/issue.net"
wget -O m-theme "${repo}menu/m-theme.sh"
wget -O speedtest "${repo}install/speedtest_cli.py"
wget -O xp "${repo}install/xp.sh"

chmod +x issue
chmod +x m-theme
chmod +x speedtest
chmod +x xp
cd

#if [ ! -f "/etc/cron.d/xp_otm" ]; then
cat> /etc/cron.d/xp_otm << END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 0 * * * root /usr/bin/xp
END
#fi

#if [ ! -f "/etc/cron.d/bckp_otm" ]; then
cat> /etc/cron.d/bckp_otm << END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 5 * * * root /usr/bin/bottelegram
END
#fi

#if [ ! -f "/etc/cron.d/autocpu" ]; then
cat> /etc/cron.d/autocpu << END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/1 * * * * root /usr/bin/autocpu
END
#fi

cat> /etc/cron.d/tendang << END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/1 * * * * root /usr/bin/tendang
END

cat> /etc/cron.d/xraylimit << END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0
*/1 * * * * root /usr/bin/xraylimit
END

service cron restart >/dev/null 2>&1
service cron reload >/dev/null 2>&1
service cron start >/dev/null 2>&1

# remove unnecessary files
apt autoclean -y >/dev/null 2>&1
apt -y remove --purge unscd >/dev/null 2>&1
apt-get -y --purge remove samba* >/dev/null 2>&1
apt-get -y --purge remove apache2* >/dev/null 2>&1
apt-get -y --purge remove bind9* >/dev/null 2>&1
apt-get -y remove sendmail* >/dev/null 2>&1
apt autoremove -y >/dev/null 2>&1
# finishing
cd
chown -R www-data:www-data /home/vps/public_html

rm -f /root/key.pem
rm -f /root/cert.pem
rm -f /root/ssh-vpn.sh
rm -f /root/bbr.sh
rm -rf /etc/apache2

clear
