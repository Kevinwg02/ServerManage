# 🛠️ Ubuntu Server Setup Scripts 

Basics to install for a fresh server.


## 📜 Custom MOTD Setup

```bash

echo "Installing figlet..."
apt update && sudo apt install -y figlet
apt install neofetch -y

echo "Disabling default MOTD components..."
sudo chmod -x /etc/update-motd.d/50-motd-news 2>/dev/null
sudo chmod -x /etc/update-motd.d/10-help-text 2>/dev/null
sudo chmod -x /etc/update-motd.d/85-fwupd 2>/dev/null
sudo chmod -x /etc/update-motd.d/90-updates-available 2>/dev/null
sudo chmod -x /etc/update-motd.d/91-contract-ua-esm-status 2>/dev/null
sudo chmod -x /etc/update-motd.d/91-release-upgrade 2>/dev/null
sudo chmod -x /etc/update-motd.d/92-unattended-upgrades 2>/dev/null
sudo chmod -x /etc/update-motd.d/95-hwe-eol 2>/dev/null
sudo chmod -x /etc/update-motd.d/97-overlayroot 2>/dev/null
sudo chmod -x /etc/update-motd.d/98-fsck-at-reboot 2>/dev/null
sudo chmod -x /etc/update-motd.d/98-reboot-required 2>/dev/null

echo "Ensuring useful info scripts are enabled..."
sudo chmod +x /etc/update-motd.d/00-header
sudo chmod +x /etc/update-motd.d/50-landscape-sysinfo


# Create custom MOTD script
echo "Creating custom welcome banner..."
sudo tee /etc/update-motd.d/99-custom > /dev/null << 'EOF'
#!/bin/bash
echo -e "\e[1;32m"
figlet -w 100 "Welcome to super Server"
echo -e "\e[0m"
EOF

# Make custom script executable
sudo chmod +x /etc/update-motd.d/99-custom

# Run test
echo "Running MOTD test output..."
run-parts /etc/update-motd.d/

```
## 🔧Management System 


### Webmin

```bash
echo "🔧 Installation de Webmin..."
wget -q http://www.webmin.com/jcameron-key.asc -O- | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/webmin.gpg
sudo sh -c 'echo "deb https://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
sudo apt update
sudo apt install -y webmin
```

```bash
## -- Cockpit --

echo "🔧 Installation de Cockpit..."

sudo apt update && sudo apt install cockpit cockpit-docker -y
sudo systemctl enable --now cockpit

```


##  Install FileBrowser 

```bash
!/bin/bash

echo "[1/6] Installing FileBrowser..."
curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

# ---- Create config directory and config file ----


echo "[2/6] Creating config directory and YAML config..."
sudo mkdir -p /etc/filebrowser

sudo tee /etc/filebrowser/.filebrowser.yaml > /dev/null <<EOF
port: 8080
address: 0.0.0.0

root: /
database: /etc/filebrowser/filebrowser.db
EOF

# ---- Create systemd service ----
echo "[3/6] Creating systemd service..."
sudo tee /etc/systemd/system/filebrowser.service > /dev/null <<EOF
[Unit]
Description=File Browser Service
After=network.target

[Service]
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/filebrowser -c /etc/filebrowser/.filebrowser.yaml

[Install]
WantedBy=multi-user.target
EOF

# ---- Reload systemd ----
echo "[4/6] Reloading systemd..."
sudo systemctl daemon-reload

# ---- Start and enable the service ----
echo "[5/6] Starting FileBrowser service..."
sudo systemctl start filebrowser.service
sudo systemctl enable filebrowser.service

# ---- Done ----
echo "[6/6] Installation complete."
echo "Access FileBrowser at: http://<your-server-ip>:8080"
echo "Login with username: admin  |  password: admin"
```

### Metube

Little docker image with web interface to download from youtube. You need to download the metube-docker-compose.yml, rename it to docker-compose.yml.

The up command is supposed to be lunch from the folder. It downloads music, videos and even playlists!

```bash
docker pull alexta69/metube
docker compose up -d
```


To make an alias permenant you need to add it to the file "bashrc": 
nano ~/.bashrc
go down with the other aliases:
alias count="ls | wc -l"
To apply the new bashrc do:
source ~/.bashrc


### Navidrome

```bash
services:
  navidrome:
    image: deluan/navidrome:latest
    ports:
      - "4533:4533"
    restart: unless-stopped
    volumes:
      - "/root/music:/music:ro"
```

