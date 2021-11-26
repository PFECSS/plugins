#!/bin/bash

# Arch config for juiceshop
{
    echo "[*] - Updating repos"
    pacman -q --noprogressbar -Sy
    echo "[*] - Installing LAMP packages"
    pacman -q --noconfirm --noprogressbar -S \
    nodejs-lts-fermium \
    npm
    echo "[*] - Installing juiceshop"
    git clone https://github.com/juice-shop/juice-shop.git /srv/http/juiceshop
    cd /srv/http/juiceshop
    npm install
    cat <<EOF > /etc/systemd/system/juiceshop.service
[Unit]
Description=Juiceshop webapp
Requires=network.target
After=network.target

[Service]
ExecStart=/usr/lib/node_modules/npm start --prefix /srv/http/juiceshop
Type=forking

[Install]
WantedBy=multi-user.target
EOF
        systemctl daemon-reload
        systemctl daemon-reexec
        systemctl enable juiceshop.service
        systemctl start juiceshop.service
} || {
    echo "[!!!] - An error occurred"
}