# 🛠️ Ubuntu Server Setup Scripts 

Basics to install for a fresh server.

To make an alias permenant you need to add it to the file: nano ~/.bashrc 
go down with the other aliases: alias count="ls | wc -l"
To apply the new bashrc do: source ~/.bashrc

# Ubuntu Server
Start with all of the updates; 

```bash
apt update && apt upgrade -y
```

Then to use a script, you first have to make it executable with :

```bash
chmod +x file
```

# Web Mananagement

Installed on host: 
- cockpit
- webmin
  - fail2ban
- filebrowser

 **Note:** fail2ban is installed with webmin as a module.

# Multimedia Server Apps:
- docker
- metube
- navidrome
- plex
- jellyfin
- picard
- nginx

