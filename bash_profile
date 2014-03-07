# Test for an interactive shell.
if [[ $- != *i* ]] ; then
	return
fi

# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Enable history appending instead of overwriting.
shopt -s histappend

#-------------------------------------------------------------
# Adicional bash files
#-------------------------------------------------------------
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi
if [ -f ~/.bash_functions ]; then
	. ~/.bash_functions;
fi

#-------------------------------------------------------------
# Color definitions
#-------------------------------------------------------------
Black=$'\e[0;30m'
Red=$'\e[0;31m'
Green=$'\e[0;32m'
Yellow=$'\e[0;33m'
Blue=$'\e[0;34m'
Purple=$'\e[0;35m'
Cyan=$'\e[0;36m'
White=$'\e[0;37m'
BBlack=$'\e[1;30m'
BRed=$'\e[1;31m'
BGreen=$'\e[1;32m'
BYellow=$'\e[1;33m'
BBlue=$'\e[1;34m'
BPurple=$'\e[1;35m'
BCyan=$'\e[1;36m'
BWhite=$'\e[1;37m'

# Color Reset
NC=$'\e[0m'

# Background
On_Black=$'\e[40m'
On_Red=$'\e[41m'
On_Green=$'\e[42m'
On_Yellow=$'\e[43m'
On_Blue=$'\e[44m'
On_Purple=$'\e[45m'
On_Cyan=$'\e[46m'
On_White=$'\e[47m'

# Bold White on red background
ALERT=${BWhite}${On_Red}

#------------------------------------------------
# GIT
#------------------------------------------------
function git_prompt_info() {
	local dir=. head
	until [ "$dir" -ef / ]; do
		if [ -f "$dir/.git/HEAD" ]; then
			head=$(< "$dir/.git/HEAD")
			git_info="[ ${Yellow}"
			if [[ $head == ref:\ refs/heads/* ]]; then
				git_info="${git_info}${head#*/*/}"
			elif [[ $head != '' ]]; then
				git_info="$git_info (detached)"
			else
				git_info="$git_info (unknown)"
			fi
			git_info="${git_info}${NC} ]"
			return
		fi
		dir="../$dir"
	done
	git_info=''
}

#------------------------------------------------
# Lists the most recent modified files
#------------------------------------------------
function lsnew() {
	ls -lt ${1+"$@"} | head -20;
}

# Customized prompt
# → ►
PROMPT_COMMAND="echo -n '${BBlack}$(date +%Y-%m-%d) ${NC}'; $PROMPT_COMMAND"
PROMPT=""

# FS path
PROMPT="${PROMPT}[ \[${Red}\]\w\[${NC}\] ]"

# Git repo
PROMPT_COMMAND="git_prompt_info; $PROMPT_COMMAND"
PROMPT="${PROMPT}\$git_info"

PROMPT="${PROMPT}
\[${BBlack}\]$(date +%H:%M) \[${Blue}\]${LOGNAME}\[${BYellow}\]@\[${BBlue}\]"`hostname`"\[${NC}\]\[${BGreen}\] → \[${NC}\]"

#------------------------------------------------
# EXPORTS
#------------------------------------------------
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PS1=$PROMPT
export PATH=$PATH:/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/local:/usr/local/bin:/usr/local/sbin
# Setting PATH for Python 2.7
export PATH=$PATH:/Library/Frameworks/Python.framework/Versions/2.7/bin
# GIT
export PATH=$PATH:/usr/local/git
export EDITOR='subl'

# Set tab-completion to be case-insensitive
# set completion-ignore-case On

# Tab completion for sudo
# complete -cf sudo

# Show all tab-completed matches
# set show-all-if-ambiguous on

# Set all symlinked-directories to be shown
# set show-all-symlinked-directories