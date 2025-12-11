echo "Waiting for system to load"
sleep 60
echo "Starting sequential package installation and updates..."
echo "---"

# 1. Update package lists
echo "Running: sudo apt update"
sudo apt update
if [ $? -ne 0 ]; then
    echo "ERROR: 'sudo apt update' failed. Stopping script."
    exit 1
fi
echo "Update successful."
echo "---"

# 2. Install core tools
echo "Installing Tools"
sudo apt install -y unzip hashcat vim tmux gzip p7zip
if [ $? -ne 0 ]; then
    echo "ERROR: Core package installation failed. Stopping script."
    exit 1
fi
echo "Core package installation successful."
echo "---"

# 3. Install specific NVIDIA components
echo "Installing Nvidia Drivers"
sudo apt -V install libnvidia-compute-580 nvidia-dkms-580-open
if [ $? -ne 0 ]; then
    echo "ERROR: NVIDIA package installation failed. Stopping script."
    exit 1
fi
echo "NVIDIA package installation successful."
echo "---"

echo "All commands executed successfully."


# Get password Lists
echo "Gathering password lists"
wget https://weakpass.com/download/2012/weakpass_4.txt.7z
7z x weakpass_4.txt.7z
cat weakpass_4.txt > temp.txt
wget https://crackstation.net/files/crackstation.txt.gz
gunzip crackstation.txt.gz
wget https://github.com/RykerWilder/rockyou.txt/raw/refs/heads/main/rockyou.txt.zip
unzip rockyou.txt.zip
cat rockyou.txt crackstation.txt >> temp.txt
echo "Sorting final wordlist to wordlist.txt"
LC_ALL=C sort -u --parallel=16 -S 75 temp.txt > wordlist.txt
/bin/rm temp.txt

# Get Rules
echo "Getting rules"
wget https://raw.githubusercontent.com/samirettali/password-cracking-rules/refs/heads/master/best64.rule
wget https://raw.githubusercontent.com/samirettali/password-cracking-rules/refs/heads/master/T0XlC.rule
wget https://raw.githubusercontent.com/samirettali/password-cracking-rules/refs/heads/master/OneRuleToRuleThemAll.rule
wget https://raw.githubusercontent.com/samirettali/password-cracking-rules/refs/heads/master/dive.rule

# Set terminal
echo "Configuring terminal for zsh and tmux"
wget https://raw.githubusercontent.com/jdksec/install/master/.vimrc -O ~/.vimrc
wget https://raw.githubusercontent.com/jdksec/install/master/.tmux.conf -O ~/.tmux.conf
