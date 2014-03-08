#!/bin/sh

if [ ! -d "$HOME/.dotfiles" ]; then
	echo "Installing ekeller dotfiles"
	git clone https://ekeller@bitbucket.org/ekeller/dotfiles.git "$HOME/.dotfiles"
	cd "$HOME/.dotfiles"
	scp bash_aliases ~/.bash_aliases
	scp bash_profile ~/.bash_profile
	# . osx/defaults.sh
else
	echo "dotfiles already installed"
fi