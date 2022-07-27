read -p "Are you running this as root?" null
read -p "Have you setup a ssh key for the root user?" null
sudo apt install autossh
read -p "Enter host: " host
read -p "Emter port: " port
ssh-keyscan -H $host
sudo systemctl disable autossh.service
sudo echo """[Unit]
Description=AutoSSH Tunnel
After=network.target

[Service]
User=root
ExecStart=/usr/bin/autossh -o \"StrictHostKeyChecking=no\" -M 0 root@$host -p 22 -o \"ExitOnForwardFailure=yes\" -o \"ServerAliveInterval 30\" -o \"ServerAliveCountMax 3\" -N -R $port:localhost:22
Restart=always
RestartSec=30

[Install]
WantedBy=multi-user.target""" > /etc/systemd/system/autossh.service

sudo cat /etc/systemd/system/autossh.service
sudo systemctl daemon-reload
sudo systemctl enable autossh.service
sudo systemctl start autossh.service
sleep 10
sudo systemctl status autossh.service
