#!/bin/sh
yum update -y&&yum install gunzip wget axel -y
apt update -y&&apt install gunzip wget axel -y

mkdir -p /home/gost
cd /tmp/
axel -k https://github.com/ginuerzh/gost/releases/download/v2.11.1/gost-linux-amd64-2.11.1.gz -o /tmp/gost.gz
gunzip /tmp/gost.gz
chmod 755 gost-linux-amd64
mv gost-linux-amd64 /bin/gost
cat > /lib/systemd/system/gost-serv.service <<EOF
[Unit]
Description=gost
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/usr/bin/nohup bash /home/gost/*.sh >/dev/null 2>&1 &

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable gost-serv.service
