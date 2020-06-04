# Basic tool installation

apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade
apt-get -y install curl
apt-get -y install git
apt-get -y install net-tools
apt-get -y install zsh
apt-get -y install vim
apt-get -y install tmux
apt-get -y  postgresql postgresql-contrib

# Install golang
wget https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.14.4.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
go version

# Create dotfiles
cat .vimrc > ~/.vimrc
cat .tmux.conf > ~/.tmux.conf
cat .zprofile > ~/.zprofile

# Docker install
apt-get remove docker docker-engine docker.io containerd runc
apt-get install apt-transport-https ca-certificates gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io

curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.zshrc
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc

# Dropbox install
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
