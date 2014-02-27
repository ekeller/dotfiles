# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

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
# PS1="\W $ "
export PS1="\[\e[1;32m\]${LOGNAME}\[\e[m\]\[\e[0;36m\]@\[\e[m\]\[\e[1;31m\]"`hostname`"\[\e[m\]\[\e[0;36m\]: \[\e[m\]\[\e[1;33m\]\w\[\e[m\]"`echo "\n\r"`"\[\e[1;37m\]$ \[\e[m\]"


export PATH=$PATH:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin
# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
export PATH=$PATH:/usr/bin:/usr/local/bin:/usr/local:/usr/local/git:/Library/Frameworks/Python.framework/Versions/2.7/bin

export EDITOR='subl'


### Set tab-completion to be case-insensitive
set completion-ignore-case

### Show all tab-completed matches
set show-all-if-ambiguous

### Set all symlinked-directories to be shown
set show-all-symlinked-directories