#!/bin/bash

while getopts ":h"


dotfilesrepo=""
progsfile=""

error() {
	echo "ERROR: $1"
}

echo "Let's make sure we're up to date first"
initialCheck() {
	pacman -Syyu --noconfirm --needed dialog || {
		echo "Are you running as root? Are you connected to the internet?"
		exit
	}
}

#Installing yay
installYay() {
	echo "Do you have yay?"
	if yay -Syy; then
		echo "You're good to go."
	else
		echo "Installing yay"
		pacman -S --noconfirm --needed git base-devel
		cd /tmp
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si
		cd ..
	fi
}

# Adding user + home directory.
# adduser(){
# read -p "Please enter a name for a new user: " name
# if useradd -m "$name"
# then
# 	echo "Now enter your password."
# 	if passwd "$name"
# 	then
# 		echo "Great, onto the next step."
# 	else
# 		echo "Did you enter anything? Did you retype it right?"
# 		exit
# 	fi
# else
# 	echo "Did you enter anything? Did you use illegal characters?"
# 	exit
# fi
# }
mainInstall() {
	echo "$n of $total - Installing $1 - $2"
	pacman --noconfirm --needed -S "$1" >/dev/null
}

aurInstall() {
	echo "$n of $total - Installing $1 - $2"
	sudo -u "$name" yay -S --noconfirm "$1" >/dev/null
}

#Install script
installLoop() {
	([ -f "$progsfile" ]) && cp "$progsfile" /tmp/programs.csv) || curl -Ls "$progsfile" | sed '/^#/d' > /tmp/progs.csv
	while IFS=, read -r tag program comment; do
		n=$((n + 1))
		echo "$comment"
		case "$tag" in
		"") mainInstall "$program" "$comment" ;;
		"A") aurInstall "$program" "$comment" ;;
		"G") ;;
		"P") ;;
		esac

	done </tmp/programs.csv
}

#Enabling services
systemctl enable sddm.service

#Changing keyboard type
localectl --no-convert set-x11-keymap us pc105 intl

# Main script
initialCheck
installYay || error "User exited the program"
