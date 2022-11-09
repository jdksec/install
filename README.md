# Install process
Works on WSL & Linux

## Small Install

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/jdksec/install/master/install-small.sh)"
```

# Docker

```
sudo su
sh -c "$(curl -fsSL https://raw.githubusercontent.com/jdksec/install/master/runasroot-docker.sh)"
```

## Install environment

```
git clone https://github.com/jdksec/install.git
cd install
vim install.sh
chmod 777 install.sh
./install.sh
```

Once finished

```
ssh-keygen
```

## Install WSL (Windows)

Open powershell as admin

```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```
reboot

Now go to windows store and download ubuntu and install

Once installed install Windows Terminal from windows store.
