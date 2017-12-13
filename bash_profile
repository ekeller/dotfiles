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

HOUR=$(date "+%H");

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

    REDIS=$(ps aux | grep '[r]edis');
    if [ -n '$REDIS' ]; then
        echo 'REDIS is already running!';
    else
        echo 'Start REDIS: redis-server';
        redis-server
    fi

    NGINX=$(ps aux | grep '[n]ginx');
    if [ -n'$NGINX' ]; then
        echo 'NGINX is already running!';
    else
        echo 'Start NGINX: sudo nginx';
        sudo nginx
    fi

    MYSQL=$(ps aux | grep '[m]ysql');
    if [ -n'$MYSQL' ]; then
        echo 'MYSQL is already running!';
    else
        echo 'Start MYSQL: mysql.server start';
        mysql.server start
    fi

    echo;
    echo 'BrowserStackLocal --key VkR9AvRsgWaeZwrhwVth';
    echo;
    update_repos;
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
    sudo nginx -s stop
    mysql.server stop
    kill $(ps aux | grep '[r]edis' | awk '{print $2}')
    kill $(ps aux | grep '[c]elery' | awk '{print $2}')
    kill $(ps aux | grep '[p]ython' | awk '{print $2}')
}

function update_repos() {
    echo 'UPDATING YOUR REPOS, YOU ARE WELCOME!';
    echo;
    ca;
    pwd;
    echo '================================';
    git checkout qa;
    git pull ca qa;
    echo;
    fe;
    pwd;
    echo '================================';
    git checkout qa;
    git pull ca qa;
    echo;
    sg;
    pwd;
    echo '================================';
    git checkout qa;
    git pull ca qa;
    echo;
    mt;
    pwd;
    echo '================================';
    git checkout qa;
    git pull ca qa;
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

# ST3
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

export CONTAINER_ENVIRONMENT='local'