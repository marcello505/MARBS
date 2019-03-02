useradd -m marcello
passwd marcello
pacman -S networkmanager net-tools
systemctl enable sddm.service networkmanager.service
