#!/bin/sh
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
