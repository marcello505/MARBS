useradd -m marcello
passwd marcello
pacman -S networkmanager net-tools
systemctl enable sddm.service networkmanager.service
localectl --no-convert set-x11-keymap us,us pc105 intl, grp:alt_shift_toggle
