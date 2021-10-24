# Install process
Works on WSL & Linux

## Install ohmyzsh

```
sudo apt install -y zsh git curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Install environment

```
git clone https://github.com/jdksec/install.git
cd install
chmod 777 install.sh
sudo ./install.sh
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
