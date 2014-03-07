#!/bin/sh

if [ ! -d "$HOME/.dotfiles" ]; then
	echo "Installing dotfiles for the first time"
	git clone https://ekeller@bitbucket.org/ekeller/dotfiles.git "$HOME/.dotfiles"
	cd "$HOME/.dotfiles"
	#[ "$1" == "ask" ] && export ASK="true"
	#rake install
else
	echo "dotfiles already installed"
fi