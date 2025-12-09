sudo apt update
sudo apt install -y unzip hashcat vim tmux gunzip
sudo apt -V install libnvidia-compute-580 nvidia-dkms-580-open


# Get password Lists
wget https://crackstation.net/files/crackstation.txt.gz
gunzip crackstation.txt.gz
wget https://github.com/RykerWilder/rockyou.txt/raw/refs/heads/main/rockyou.txt.zip
unzip rockyou.txt.zip
cat rockyou.txt crackstation.txt > wordlist.txt

# Get Rules
wget https://raw.githubusercontent.com/samirettali/password-cracking-rules/refs/heads/master/best64.rule
wget https://raw.githubusercontent.com/samirettali/password-cracking-rules/refs/heads/master/T0XlC.rule
wget https://raw.githubusercontent.com/samirettali/password-cracking-rules/refs/heads/master/OneRuleToRuleThemAll.rule
wget https://github.com/samirettali/password-cracking-rules/blob/master/dive.rule

# Set terminal
wget https://raw.githubusercontent.com/jdksec/install/master/.vimrc -O ~/.vimrc
wget https://raw.githubusercontent.com/jdksec/install/master/.tmux.conf -O ~/.tmux.conf
