#!/bin/sh

# Try/Catch in bash
{
    echo "[*] - Installing ufw"
    pacman -q --noconfirm -Sy
    pacman -q --noconfirm -S ufw
    echo "[*] - Configuring ufw"
    systemctl disable iptables
    systemctl enable ufw
    systemctl start ufw
    sleep 2
    ufw --force enable
    ufw default deny
    ufw default deny outgoing
    ufw allow 53
    ufw allow 80
    ufw allow 443
    echo "[*] - Configuration done."
} || {
    echo "[!!!] - Error while configuring ufw"
} 
