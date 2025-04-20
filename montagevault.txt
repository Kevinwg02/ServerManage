#!/bin/bash

MOUNT_POINT="/hdd"

echo "🔍 Vérification du système de fichiers sur /dev/sdb2..."
FS_TYPE=$(sudo blkid -o value -s TYPE /dev/sdb2)

if [ -z "$FS_TYPE" ]; then
  echo "⚠️ Aucun système de fichiers détecté, formatage en ext4..."
  sudo mkfs.ext4 /dev/sdb2
  FS_TYPE="ext4"
else
  echo "✅ Système de fichiers détecté : $FS_TYPE"
fi

# Création du point de montage
sudo mkdir -p $MOUNT_POINT

# Récupération de l'UUID
UUID=$(sudo blkid -s UUID -o value /dev/sdb2)

# Sauvegarde de fstab
sudo cp /etc/fstab /etc/fstab.old

# Nettoyage si la ligne existe déjà
sudo sed -i "/$UUID/d" /etc/fstab

# Ajout au fstab
echo "📌 Ajout au fstab pour un montage persistant..."
if [[ "$FS_TYPE" == "ntfs" ]]; then
  echo "UUID=$UUID  $MOUNT_POINT  ntfs-3g  defaults,windows_names,locale=en_US.utf8  0  0" | sudo tee -a /etc/fstab
else
  echo "UUID=$UUID  $MOUNT_POINT  $FS_TYPE  defaults  0  2" | sudo tee -a /etc/fstab
fi

# Montage
sudo systemctl daemon-reload
sudo mount -a

echo "✅ Le disque est monté sur $MOUNT_POINT"
