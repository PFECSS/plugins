#!/bin/sh

echo "[*] - Configuring users"

{
    useradd admin
    echo -e "admin:papamaman" | chpasswd
    usermod -aG video,audio,disk,lp,storage,wheel admin
    echo "[*] - Adding user to sudoers"
    sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
    echo "[*] - Done."
} || {
    echo "[!!!] - Unable to configure user"
}

echo "[*] - FIN Configuring users"

echo "[**] - Installing & Configuring apache2"
{
    pacman -S wget
    pacman -S apache2
    systemctl start httpd
    touch /srv/http/index.html
    touch /srv/robots.txt
}
echo "[**] - Fin Config Apache2"

echo "[***] - Configuration Plugin pour attack SSH BruteForce"
{
    echo"
        <h1> Hello World </h1>
        <h2> Vous ne m'aurez jamais HAHAHAHAHAHA !!! </h2>

    " > /srv/http/index.html

    echo"
        User-agent: *
        Allow: index.html

        User-agent: *
        Allow: libPassword.txt
    " > /srv/http/robots.txt

    wget https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt
    cp /home/eseoquali/Downloads/rockyou.txt /srv/http/libPassword.txt
    rm /home/eseoquali/Downloads/rockyou.txt
}
echo "[***] - FIN  Configuration Plugin pour attack BruteForce"

