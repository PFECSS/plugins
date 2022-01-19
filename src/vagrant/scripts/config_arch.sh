#!/bin/bash

# Try/Catch in bash
{
    echo "[*] - Time configuration"
    timedatectl
    timedatectl set-ntp true
    echo "[*] - Setup locales"
    ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
    locale-gen
    echo 'fr_FR.UTF-8 UTF8' >> /etc/locale.gen 
    echo LANG="fr_FR_UTF-8" > /etc/locale.conf
    echo KEYMAP=fr > /etc/vconsole.conf
    echo "[*] - Synchronizing database"
    pacman -q -Sy
    echo "[*] - Installing misc packages"
    pacman -q --noconfirm -S git wget
    sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config    
    systemctl restart sshd
    echo "[*] - Configuration done."
} || {
    echo "[!!!] - Error while doing Archlinux configuration"
}
