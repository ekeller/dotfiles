# Test for an interactive shell.
if [[ $- != *i* ]] ; then
	return
fi

# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Enable history appending instead of overwriting.
shopt -s histappend

# Read /etc/bashrc, if present.
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#-------------------------------------------------------------
# Color definitions (taken from Color Bash Prompt HowTo).
#-------------------------------------------------------------

# Normal Colors
Black='\e[0;30m'
Red='\e[0;31m'
Green='\e[0;32m'
Yellow='\e[0;33m'
Blue='\e[0;34m'
Purple='\e[0;35m'
Cyan='\e[0;36m'
White='\e[0;37m'

# Bold
BBlack='\e[1;30m'
BRed='\e[1;31m'
BGreen='\e[1;32m'
BYellow='\e[1;33m'
BBlue='\e[1;34m'
BPurple='\e[1;35m'
BCyan='\e[1;36m'
BWhite='\e[1;37m'

# Background
On_Black='\e[40m'
On_Red='\e[41m'
On_Green='\e[42m'
On_Yellow='\e[43m'
On_Blue='\e[44m'
On_Purple='\e[45m'
On_Cyan='\e[46m'
On_White='\e[47m'

# Color Reset
NC="\e[m"

# Bold White on red background
ALERT=${BWhite}${On_Red}

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm|aterm|kterm|gnome)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac

# Customized prompt
# →
export PS1="
\[${Red}\]\w
\[${BCyan}\]${LOGNAME}\[${BYellow}\]@\[${BGreen}\]"`hostname`"\[${NC}\]\[${BBlue}\] ► \[${NC}\]"

export PATH=$PATH:/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/local:/usr/local/bin:/usr/local/sbin

# Setting PATH for Python 2.7
export PATH=$PATH:/Library/Frameworks/Python.framework/Versions/2.7/bin

# GIT
export PATH=$PATH:/usr/local/git

export EDITOR='subl'


### Set tab-completion to be case-insensitive
set completion-ignore-case

### Show all tab-completed matches
set show-all-if-ambiguous

### Set all symlinked-directories to be shown
set show-all-symlinked-directories