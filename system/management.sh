echo "🔧 Installation de Webmin..."
wget -q http://www.webmin.com/jcameron-key.asc -O- | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/webmin.gpg
sudo sh -c 'echo "deb https://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
sudo apt update
sudo apt install -y webmin

echo "🔧 Installation de Cockpit..."

sudo apt update && sudo apt install cockpit cockpit-docker -y
sudo systemctl enable --now cockpit
