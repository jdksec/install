# Basic tool installation

# These are not all on one line as sometimes a package wont install interupting the whole install process.
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade
apt-get -y install aircrack-ng
apt-get -y install apache2
apt-get -y install autossh
apt-get -y install ca-certificates
apt-get -y install cargo
apt-get -y install chromium-browser
apt-get -y install crackmapexec
apt-get -y install curl
apt-get -y install dig
apt-get -y install fimap
apt-get -y install ftp
apt-get -y install gem
apt-get -y install git
apt-get -y install git-core
apt-get -y install gobuster
apt-get -y install googler
apt-get -y install gron
apt-get -y install gron
apt-get -y install gunzip
apt-get -y install hashcat
apt-get -y install hexedit
apt-get -y install html2text
apt-get -y install httpie
apt-get -y install hydra
apt-get -y install john
apt-get -y install jq
apt-get -y install libcurl4-openssl-dev 
apt-get -y install libsasl2-2
apt-get -y install libsasl2-modules
apt-get -y install libssl-dev
apt-get -y install locate
apt-get -y install lynx
apt-get -y install masscan
apt-get -y install net-tools
apt-get -y install nikto
apt-get -y install nmap
apt-get -y install nsrecords
apt-get -y install onesixtyone
apt-get -y install openssh
apt-get -y install openssl
apt-get -y install openvpn
apt-get -y install php
apt-get -y install pip
apt-get -y install proxychains
apt-get -y install python
apt-get -y install python-m2crypto
apt-get -y install python-pip
apt-get -y install python3
apt-get -y install python3-pip
apt-get -y install ranger
apt-get -y install rar
apt-get -y install ruby
apt-get -y install screen
apt-get -y install socat
apt-get -y install sqlmap
apt-get -y install sslscan
apt-get -y install ssmtp
apt-get -y install tcpdump
apt-get -y install theharvester
apt-get -y install tmux
apt-get -y install tor
apt-get -y install vim
apt-get -y install wafw00f
apt-get -y install whatweb
apt-get -y install whois
apt-get -y install xvfb
apt-get -y install youtube-dl
apt-get -y install zip
apt-get -y install zsh

# install pip tools
pip3 install awscli
pip3 install boto3
pip3 install censys
pip3 install coloredlogs
pip3 install futures
pip3 install pwntools
pip3 install pyminifier
pip3 install pymongo
pip3 install pytest-xdist
pip3 install python-Wappalyzer
pip3 install rainbowstream
pip3 install requests
pip3 install s3recon
pip3 install termcolor
pip3 install trufflehog
pip3 install urllib3
pip3 install wappalyzer
pip3 install webscreenshot
pip3 install wfuzz

# Metasploit
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall
rm msfinstall

# Install golang
wget https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.14.4.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
go version

# install go tools
go get -u github.com/ameenmaali/qsfuzz
go get -u github.com/ffuf/ffuf
go get -u github.com/haccer/subjack
go get -u github.com/hahwul/dalfox
go get -u github.com/hakluke/hakrawler
go get -u github.com/Ice3man543/SubOver
go get -u github.com/jaeles-project/gospider
go get -u github.com/michenriksen/gitrob
go get -u github.com/OJ/gobuster
go get -u github.com/OWASP/Amass
go get -u github.com/projectdiscovery/chaos-client/cmd/chaos
go get -u github.com/projectdiscovery/dnsprobe
go get -u github.com/projectdiscovery/httpx/cmd/httpx
go get -u github.com/projectdiscovery/naabu/cmd/naabu
go get -u github.com/projectdiscovery/nuclei/v2/cmd/nuclei
go get -u github.com/projectdiscovery/shuffledns/cmd/shuffledns
go get -u github.com/projectdiscovery/subfinder/cmd/subfinder
go get -u github.com/ropnop/kerbrute
go get -u github.com/sensepost/gowitness
go get -u github.com/subfinder/subfinder
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
go get -u github.com/tomnomnom/qsreplace
go get -u github.com/tomnomnom/tok
go get -u github.com/tomnomnom/unfurl
go get -u github.com/tomnomnom/waybackurls

# Create dotfiles
cat .vimrc > ~/.vimrc
cat .tmux.conf > ~/.tmux.conf
cat .zprofile > ~/.zprofile
cat .zprofile > ~/.zprofile
cat .zshrc > ~/.zshrc
cp jdksec.zsh-theme ~/.oh-my-zsh/themes/

# Docker install
#apt-get remove docker docker-engine docker.io containerd runc
#apt-get install apt-transport-https ca-certificates gnupg-agent software-properties-common
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
#apt-get update
#apt-get install docker-ce docker-ce-cli containerd.io

#curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#sudo chmod +x /usr/local/bin/docker-compose

# Dropbox install
#cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

# Create folders
cd ~/
mkdir .trash
mkdir Tools
mkdir Lab

# Get git repos
cd Tools
git clone https://github.com/aboul3la/Sublist3r.git
git clone https://github.com/appsecco/the-art-of-subdomain-enumeration.git
git clone https://github.com/arkadiyt/bounty-targets-data.git
git clone https://github.com/s0md3v/Arjun.git
git clone https://github.com/attackdebris/babel-sf.git
git clone https://github.com/BishopFox/GitGot.git
git clone https://github.com/nccgroup/Winpayloads.git
git clone https://github.com/breenmachine/dnsftp.git
git clone https://github.com/ropnop/kerbrute.git
git clone https://github.com/Hackplayers/evil-winrm.git
git clone https://github.com/byt3bl33d3r/cmd2powershell.git
git clone https://github.com/byt3bl33d3r/CrackMapExec.git
git clone https://github.com/c4software/python-sitemap.git
git clone https://github.com/chokepoint/azazel.git
git clone https://github.com/danielmiessler/SecLists.git
git clone https://github.com/Dionach/CMSmap.git
git clone https://github.com/lc/gau.git
git clone https://github.com/droope/droopescan.git
git clone https://github.com/stephenfewer/ReflectiveDLLInjection.git
git clone https://github.com/Edu4rdSHL/findomain.git
git clone https://github.com/epinna/tplmap.git
git clone https://github.com/FortyNorthSecurity/EyeWitness.git
git clone https://github.com/galkan/crowbar.git
git clone https://github.com/stephenfewer/ReflectiveDLLInjection.git
git clone https://github.com/GerbenJavado/LinkFinder.git
git clone https://github.com/gojhonny/CredCrack.git
git clone https://github.com/GoVanguard/legion.git
git clone https://github.com/infodox/python-pty-shells.git
git clone https://github.com/infosec-au/altdns.git
git clone https://github.com/initstring/cloud_enum.git
git clone https://github.com/inquisb/icmpsh.git
git clone https://github.com/jobertabma/relative-url-extractor.git
git clone https://github.com/jordanpotti/CloudScraper.git
git clone https://github.com/maurosoria/dirsearch.git
git clone https://github.com/mfontanini/dot11decrypt.git
git clone https://github.com/n1nj4sec/pupy.git
git clone https://github.com/nahamsec/bbht.git
git clone https://github.com/nccgroup/autochrome.git
git clone https://github.com/NetSPI/cmdsql.git
git clone https://github.com/InfosecMatter/default-http-login-hunter.git
git clone https://github.com/ameenmaali/qsfuzz.git
git clone https://github.com/nullmode/gnmap-parser.git
git clone https://github.com/PowerShellMafia/PowerSploit.git
git clone https://github.com/besimorhino/powercat.git
git clone https://github.com/ripsscanner/rips.git
git clone https://github.com/robertdavidgraham/masscan.git
git clone https://github.com/s0md3v/Arjun.git
git clone https://github.com/s0md3v/XSStrike.git
git clone https://github.com/s7ephen/pfi.git
git clone https://github.com/samratashok/nishang.git
git clone https://github.com/SecureAuthCorp/impacket.git
git clone https://github.com/sensepost/reGeorg.git
git clone https://github.com/devanshbatham/ParamSpider
git clone https://github.com/SpiderLabs/Responder.git
git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git
git clone https://github.com/T-S-A/smbspider.git
git clone https://github.com/tomnomnom/gf.git
git clone https://github.com/epinna/tplmap.git
git clone https://github.com/trustedsec/unicorn.git
git clone https://github.com/urbanadventurer/WhatWeb.git
git clone https://github.com/vincentcox/bypass-firewalls-by-DNS-history.git
git clone https://github.com/Vozzie/uacscript.git
git clone https://github.com/vrana/adminer.git
git clone https://github.com/vysec/morphHTA.git
git clone https://github.com/wireghoul/graudit.git
git clone https://github.com/xillwillx/MiniReverse_Shell_With_Parameters.git
git clone https://github.com/mhaskar/RCEScanner.git
git clone https://github.com/fox-it/mitm6.git
git clone https://github.com/sa7mon/S3Scanner.git
git clone https://github.com/projectdiscovery/nuclei-templates.git
git clone https://github.com/disclose/disclose.git
git clone https://github.com/projectdiscovery/public-bugbounty-programs.git

source ~/.zshrc
