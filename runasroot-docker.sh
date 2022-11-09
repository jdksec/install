sudo curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo echo 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable' > /etc/apt/sources.list.d/docker.list
sudo apt-get update -y
sudo apt-get remove docker docker-engine docker.io docker-compose docker-ce -y
sudo apt-get -y install docker-ce
sudo apt-get -y install docker-compose
sudo service docker status
echo "Run the following as the current user"
echo "sudo groupadd docker; sudo usermod -aG docker \$USER"
echo "Reboot or log out and backin to get permissions"
