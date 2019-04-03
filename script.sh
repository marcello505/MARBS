#!/bin/bash

echo "Let's make sure we're up to date first"
initialcheck() { pacman -Syyu --noconfirm --needed dialog || { echo "Are you running as root? Are you connected to the internet?"; exit; } ;}


#Installing yay
echo "Do you have yay?"
if yay -Syy
then
	echo "You're good to go."
else
	pacman -S --noconfirm --needed git
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ..
	rmdir -r yay
fi
