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
apt-get -y install xvfb
apt-get -y install nmap
apt-get -y install sqlmap
apt-get -y install jq
apt-get -y install gron
apt-get -y install python3
apt-get -y install python3-pip
apt-get -y install python-m2crypto
apt-get -y install autossh
apt-get -y  postgresql postgresql-contrib
apt-get -y install parallel
parallel --citation

# install pip tools
pip3 install webscreenshot

# Install golang
wget https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.14.4.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
go version

# install go tools
go get -u github.com/Ice3man543/SubOver
go get -u github.com/michenriksen/gitrob
go get -u github.com/OJ/gobuster
go get -u github.com/OWASP/Amass
go get -u github.com/tomnomnom/qsreplace
go get -u github.com/haccer/subjack
go get -u github.com/sensepost/gowitness
go get -u github.com/subfinder/subfinder
go get -u github.com/ameenmaali/qsfuzz
go get -u github.com/tomnomnom/anew
go get -u github.com/tomnomnom/assetfinder
go get -u github.com/tomnomnom/burl
go get -u github.com/tomnomnom/fff
go get -u github.com/tomnomnom/gf
go get -u github.com/tomnomnom/gron
go get -u github.com/tomnomnom/hacks/comb
go get -u github.com/tomnomnom/hacks/ettu
go get -u github.com/tomnomnom/hacks/fff
go get -u github.com/tomnomnom/hacks/html-tool
go get -u github.com/tomnomnom/hacks/tok
go get -u github.com/tomnomnom/hacks/urinteresting
go get -u github.com/tomnomnom/httprobe
go get -u github.com/tomnomnom/meg
go get -u github.com/tomnomnom/tok
go get -u github.com/tomnomnom/unfurl
go get -u github.com/tomnomnom/waybackurls
go get -u github.com/ropnop/kerbrute
go get -u github.com/jaeles-project/gospider
go get -u github.com/hahwul/dalfox
go get -u github.com/ffuf/ffuf

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

echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.zshrc
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc

# Dropbox install
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
