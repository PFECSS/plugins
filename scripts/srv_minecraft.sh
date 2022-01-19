#!/bin/bash

#required package text éditor, screen(keep server up) java(needed to run minecraft)
echo "install required package"
pacman -Syu
pacman -S -q --noconfirm vim jdk-openjdk wget


#create serveur directory 
mkdir minecraft
cd minecraft

#install and start minecraft server
wget https://launcher.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar
mv server.jar minecraft_server.1.18.1.jar
java -Xmx1024M -Xms1024M -jar minecraft_server.1.18.1.jar nogui
echo "eula=true" > eula.txt

#create script to start the server
cat <<EOF > /root/minecraft_srv.sh
#!/bin/bash
cd /root/minecraft
java -Xmx1024M -Xms1024M -jar minecraft_server.1.18.1.jar nogui &
EOF
chmod 700 /root/minecraft_srv.sh
#create a service for the server
cat <<EOF > /etc/systemd/system/minecraft_srv.service
[Unit]
Description=Start Minecraft server
Requires=network.target
After=network.target
[Service]
ExecStart=/bin/bash /root/minecraft_srv.sh
Type=forking
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl daemon-reexec
systemctl enable minecraft_srv.service
systemctl start minecraft_srv.service

