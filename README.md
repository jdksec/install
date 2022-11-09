# Install 
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

# Docker Images
```
docker run --rm -p 3000:3000 bkimminich/juice-shop
docker run -it -p 8000:8000 opensecurity/mobile-security-framework-mobsf:latest
docker pull owasp/zap2docker-stable
```

# Scan site with zap

```
docker run  --rm -v $(pwd):/zap/wrk/:rw -t owasp/zap2docker-stable zap-full-scan.py -t "https://target.site" -g gen.conf -r report.html -J report.json
```

## Install environment

```
git clone https://github.com/jdksec/install.git
cd install
vim install.sh
chmod 777 install.sh
./install.sh
```

## Install WSL (Windows)

Open powershell as admin

```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```
reboot

Now go to windows store and download ubuntu and install

Once installed install Windows Terminal from windows store.
