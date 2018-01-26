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

# Liquid Prompt
# https://github.com/nojhan/liquidprompt#test-drive-and-installation
if [ -f /usr/local/share/liquidprompt ]; then
    . /usr/local/share/liquidprompt
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion;
fi

#------------------------------------------------
# CA functions
#------------------------------------------------

HOUR=$(date "+%H");

function servicesStatus() {
    NGINX=$(ps aux | grep '[n]ginx');
    if [ -n '$NGINX' ]; then
        echo 'NGINX is NOT running!';
        echo 'Starting NGINX: sudo nginx.';
        sudo nginx
    else
        echo 'NGINX is already running!';
    fi

    MYSQL=$(ps aux | grep '[m]ysql');
    if [ -n '$MYSQL' ]; then
        echo 'MYSQL is NOT running!';
        echo 'Start MYSQL: mysql.server start';
        mysql.server start
    else
        echo 'MYSQL is already running!';
    fi

    REDIS=$(ps aux | grep '[r]edis');
    if [ -n '$REDIS' ]; then
        echo 'REDIS is NOT running!'
        echo 'Starting REDIS: redis-server.';
        redis-server
    else
        echo 'REDIS is already running!';
    fi
}

function startWorking() {
    GREETINGS='Hello, ';
    if [ $HOUR -gt 0 ] && [ $HOUR -lt 13 ]; then
        GREETINGS="$GREETINGS good morning!";
        echo $GREETINGS;
    elif [ $HOUR -gt 12 ] && [ $HOUR -lt 19 ]; then
        GREETINGS="$GREETINGS good evening!";
    elif [ $HOUR -gt 18 ] && [ $HOUR -lt 24 ]; then
        GREETINGS="$GREETINGS good night!";
    fi
    echo $GREETINGS;
    echo;
    servicesStatus;
    echo;
    # echo 'BrowserStackLocal --key VkR9AvRsgWaeZwrhwVth';
    # echo;
    # update_repos;
    # sudo nginx
    # mysql.server start
    # ./manage.py celery purge -f
    # ./manage.py celeryd -l info -Q celery
    # echo 'redis-server'
    # echo './manage.py runserver'
    # echo 'newrelic-admin run-python manage.py runserver'
    # echo 'redis-cli flushall'
}

function kca() {
    hasmysql=$(ps aux | grep '[n]ginx' | awk '{print $2}');
    if [ $hasmysql != "" ]; then
        echo 'bosta';
        #sudo nginx -s stop;
    fi
    if [ "ps aux | grep '[m]ysql' | awk '{print $2}'" != "" ]; then
        echo 'bosta';
        #mysql.server stop;
    fi
    kill -9 $(ps aux | grep '[r]edis' | awk '{print $2}')
    kill -9 $(ps aux | grep '[c]elery' | awk '{print $2}')
    kill -9 $(ps aux | grep '[p]ython' | awk '{print $2}')
}

function update_repos() {
    echo -e 'UPDATING YOUR REPOS, YOU ARE WELCOME!\n'
    ca;
    echo PULLING $(basename `pwd`) | awk '{print toupper($0)}';
    echo '================================';
    git checkout qa;
    git pull ca qa;
    echo -e '\nPUSHING TO ORIGIN';
    git push origin qa;
    echo;
    fe;
    echo PULLING $(basename `pwd`) | awk '{print toupper($0)}';
    echo '================================';
    git checkout qa;
    git pull ca qa;
    echo -e '\nPUSHING TO ORIGIN';
    git push origin qa;
    echo;
    sg;
    echo PULLING $(basename `pwd`) | awk '{print toupper($0)}';
    echo '================================';
    git checkout qa;
    git pull ca qa;
    echo -e '\nPUSHING TO ORIGIN';
    git push origin qa;
    echo;
    mt;
    echo PULLING $(basename `pwd`) | awk '{print toupper($0)}';
    echo '================================';
    git checkout qa;
    git pull ca qa;
    echo -e '\nPUSHING TO ORIGIN';
    git push origin qa;
    echo;
    bm;
    echo PULLING $(basename `pwd`) | awk '{print toupper($0)}';
    echo '================================';
    git checkout staging;
    git pull ca staging;
    echo -e '\nPUSHING TO ORIGIN';
    git push origin staging;
    echo;
    echo 'DONE! Have a good day.';
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
export PATH=${PATH}:/opt/local/bin:/opt/local/sbin:/usr/local:/usr/local/bin:/usr/local/sbin:/usr/bin

# Setting PATH for Python 2.7
# export PATH=$PATH:/Library/Frameworks/Python.framework/Versions/2.7/bin

# GIT
export PATH=$PATH:/usr/local/git

# ANDROID
# export PATH=${PATH}:/Developer/SDKs/android-sdk-macosx/platform-tools:/Developer/SDKs/android-sdk-macosx/tools

# ST3 or your editor CLI
export EDITOR='subl'

# JAVA
export JAVA_HOME=$(/usr/libexec/java_home)


# MAMP Mysql
# export PATH="/Applications/MAMP/Library/bin:$PATH"

# MAMP PHP
# export PATH=/Applications/MAMP/bin/php/php5.6.2/bin:$PATH

# NEW RELIC
export NEW_RELIC_CONFIG_FILE=~/.newrelic.ini
export NEW_RELIC_ENVIRONMENT=development

# PYENVS
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export NVM_DIR="/Users/ekeller/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export CONTAINER_ENVIRONMENT='localsheet'
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
