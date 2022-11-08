# Basic tool installation
sudo visudo
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt install zsh git tmux python3 python3-pip -y
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

chsh -s $(which zsh)
zsh
