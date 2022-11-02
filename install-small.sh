# Basic tool installation

# These are not all on one line as sometimes a package wont install interupting the whole install process.
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt install zsh git tmux -y
wget https://raw.githubusercontent.com/jdksec/install/master/.zshrc -O ~/.zshrc
wget https://raw.githubusercontent.com/jdksec/install/master/.vimrc -O ~/.vimrc
wget https://raw.githubusercontent.com/jdksec/install/master/.tmux.conf -O ~/.tmux.conf
wget https://raw.githubusercontent.com/jdksec/install/master/.zprofile -O ~/.zprofile

# Create folders
cd ~/
mkdir .trash
mkdir Tools
mkdir Lab
git clone https://github.com/jdksec/install.git

chsh -s $(which zsh)
zsh
