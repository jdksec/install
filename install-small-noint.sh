# Basic tool installation
sudo apt-get -y update
#sudo apt-get -y upgrade
#sudo apt-get -y dist-upgrade
sudo apt install zsh git tmux python3 python3-pip ruby-dev openssh-server -y
wget https://raw.githubusercontent.com/jdksec/install/master/.zshrc -O ~/.zshrc
wget https://raw.githubusercontent.com/jdksec/install/master/.vimrc -O ~/.vimrc
wget https://raw.githubusercontent.com/jdksec/install/master/.tmux.conf -O ~/.tmux.conf
wget https://raw.githubusercontent.com/jdksec/install/master/.zprofile -O ~/.zprofile

# Install golang
sudo /bin/rm -rf /usr/local/go
wget https://golang.org/dl/go1.19.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
go version
/bin/rm go1.19.3.linux-amd64.tar.gz

# Install go tools
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

# Install python tools
pip3 install updog

# Install ruby tools
sudo gem install wpscan

# Create folders
cd ~/
mkdir .trash
mkdir Tools
mkdir Lab
git clone https://github.com/jdksec/install.git
chmod +x ~/install/hostscan.sh


# Download some repos
cd ~/
cd Tools
git clone https://github.com/danielmiessler/SecLists.git
git clone https://github.com/CiscoCXSecurity/enum4linux.git
git clone https://github.com/drwetter/testssl.sh.git
chmod +x testssl.sh/testssl.sh
cd ~/

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
