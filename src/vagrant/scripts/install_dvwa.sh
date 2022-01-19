#!/bin/bash

# Arch config for dvwa
{
    echo "[*] - Updating repos"
    pacman -q --noprogressbar -Sy
    echo "[*] - Installing LAMP packages"
    pacman -q --noconfirm --noprogressbar -S \
        apache              \
        mariadb             \
        php                 \
        php-gd              \
        php-apache          \
        phpmyadmin          \
        unzip 2>&1
    echo "[*] - Installing DVWA"
    git clone https://github.com/digininja/DVWA.git /srv/http/
    sed -i 's/LoadModule mpm_event_module modules\/mod_mpm_event.so/#LoadModule mpm_event_module modules\/mod_mpm_event.so/' /etc/httpd/conf/httpd.conf
    sed -i 's/#LoadModule mpm_prefork_module modules\/mod_mpm_prefork.so/LoadModule mpm_prefork_module modules\/mod_mpm_prefork.so/' /etc/httpd/conf/httpd.conf
    echo 'LoadModule php_module modules/libphp.so' >> /etc/httpd/conf/httpd.conf
    echo 'Include conf/extra/php_module.conf' >> /etc/httpd/conf/httpd.conf
    systemctl enable httpd
    systemctl start httpd
    /usr/bin/mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
    systemctl start mariadb
    systemctl enable mariadb
    echo "[*] - DVWA database setup"
    mysql -e "CREATE DATABASE dvwa"
    mysql -e "GRANT ALL PRIVILEGES ON dvwa.* TO 'dvwa'@'localhost' IDENTIFIED BY 'p@ssw0rd'"
    mysql -e "FLUSH PRIVILEGES"
    echo "[*] - Add user www"
    useradd www-data
    usermod -aG audio,video,disk,lp,storage www-data
    echo "[*] - Filesystem configuration"
    sed -e "s|\[ 'default_security_level' \] = 'impossible';|\[ 'default_security_level' \] = 'low';|" \
    /srv/http/config/config.inc.php.dist > /srv/http/config/config.inc.php
    chmod 777 -R /srv/http/
    sed -i "s/allow_url_include = Off/allow_url_include = On/" /etc/php/php.ini
    echo 'extension=pdo_mysql' >> /etc/php/php.ini
    echo 'extension=mysqli' >> /etc/php/php.ini
    systemctl reload httpd
    systemctl restart mariadb
    echo "[*] - Done."
} || {
    echo "[!!!] - Error while setting up DVWA"
}
