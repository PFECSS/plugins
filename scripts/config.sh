#!/bin/bash
{
    echo "[+] - Creating vagrant specific configuration"
    echo '%wheel ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers
    echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/vagrant
    usermod -aG wheel,video,audio,disk,lp,storage vagrant
    mkdir -p /home/vagrant/.ssh/
    chmod 700 /home/vagrant/.ssh
    echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key' > /home/vagrant/.ssh/authorized_keys
    chmod 600 /home/vagrant/.ssh/authorized_keys
    chown -R vagrant:vagrant /home/vagrant
    echo "[*] - Creating eseoquali user"
    useradd -m eseoquali
    echo "network" | passwd --stdin eseoquali
    #echo -e "eseoquali:network" | chpasswd
    echo 'eseoquali ALL=(ALL) ALL' >> /etc/sudoers.d/eseoquali
    usermod -aG wheel,video,audio,disk,lp,storage eseoquali
    mkdir -p /home/eseoquali
    chown -R eseoquali:eseoquali /home/eseoquali
    echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen
    sed -i 's/en_EN.UTF-8 UTF-8//' /etc/locale.gen
    locale-gen
    echo "[+] - Done."
    
} || {
    echo "[!!!] - An error occurred while configuring vagrant defaults options for the box"
}