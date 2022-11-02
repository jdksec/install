# Basic tool installation

# These are not all on one line as sometimes a package wont install interupting the whole install process.
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt install zsh git tmux
wget https://raw.githubusercontent.com/jdksec/install/master/.zshrc -O ~/.zshrc
wget https://raw.githubusercontent.com/jdksec/install/master/.vimrc -O ~/.vimrc
wget https://raw.githubusercontent.com/jdksec/install/master/.tmux.conf -O ~/.tmux.conf
wget https://raw.githubusercontent.com/jdksec/install/master/.zprofile -O ~/.zprofile

# Docker install
#sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
#apt-cache policy docker-ce
#sudo apt install docker-ce docker-compose -y
#sudo systemctl disable docker
#sudo usermod -aG docker ${USER}

# Create folders
cd ~/
mkdir .trash
mkdir Tools
mkdir Lab

sudo systemctl disable apache2
sudo systemctl stop apache2
chsh -s $(which zsh)
zsh
#sudo reboot
