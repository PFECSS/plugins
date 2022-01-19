#!/bin/bash

echo "[*] - Configuring users"

{
    useradd admin
    echo -e "admin:admin" | chpasswd
    usermod -aG video,audio,disk,lp,storage,wheel admin
    echo "[*] - Adding user to sudoers"
    sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
    echo "[*] - Done."
} || {
    echo "[!!!] - Unable to configure user"
}

