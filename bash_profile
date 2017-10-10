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
if [ -f /usr/local/share/liquidprompt ]; then
	. /usr/local/share/liquidprompt
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion;
fi

#------------------------------------------------
# CA functions
#------------------------------------------------
function sca() {
	cd-ca
	find . -name '*.pyc' -delete
	sudo nginx
	mysql.server start
	./manage.py celery purge
	./manage.py celeryd -l info -Q celery
	echo 'redis-server'
	echo './manage.py runserver'
	echo 'newrelic-admin run-python manage.py runserver'
	echo 'redis-cli flushall'
}

function kca() {
	sudo nginx -s stop
	mysql.server stop
	kill $(ps aux | grep '[r]edis' | awk '{print $2}')
	kill $(ps aux | grep '[c]elery' | awk '{print $2}')
	kill $(ps aux | grep '[p]ython' | awk '{print $2}')
}

#------------------------------------------------
# Lists the most recent modified files
#------------------------------------------------
function lsnew() {
	ls -lt ${1+"$@"} | head -20;
}

#------------------------------------------------
# EXPORTS
#------------------------------------------------
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
# MAMP PHP
#export PATH=/Applications/MAMP/bin/php/php5.6.2/bin:$PATH
export PATH=${PATH}:/opt/local/bin:/opt/local/sbin:/usr/local:/usr/local/bin:/usr/local/sbin:/usr/bin
# Setting PATH for Python 2.7
#export PATH=$PATH:/Library/Frameworks/Python.framework/Versions/2.7/bin
# GIT
export PATH=$PATH:/usr/local/git
# ANDROID
#export PATH=${PATH}:/Developer/SDKs/android-sdk-macosx/platform-tools:/Developer/SDKs/android-sdk-macosx/tools
# ST3
export EDITOR='subl'
# JAVA
export JAVA_HOME=$(/usr/libexec/java_home)
# AMAZON
#export EC2_HOME=/usr/local/ec2/ec2-api-tools-1.7.5.0

#export AWS_ACCESS_KEY=AKIAIMMITMO4R5OD6B4A
#export AWS_SECRET_KEY=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

#export PATH=$PATH:$EC2_HOME/bin

# Set tab-completion to be case-insensitive
# set completion-ignore-case On

# Tab completion for sudo
# complete -cf sudo

# Show all tab-completed matches
# set show-all-if-ambiguous on

# Set all symlinked-directories to be shown
# set show-all-symlinked-directories
##
# Your previous /Users/ekeller/.bash_profile file was backed up as /Users/ekeller/.bash_profile.macports-saved_2014-09-16_at_23:23:25
##

# MacPorts Installer addition on 2014-09-16_at_23:23:25: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# MAMP Mysql
#export PATH="/Applications/MAMP/Library/bin:$PATH"

# NEW RELIC
export NEW_RELIC_CONFIG_FILE=~/.newrelic.ini
export NEW_RELIC_ENVIRONMENT=development

# PYENVS
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export NVM_DIR="/Users/ekeller/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

