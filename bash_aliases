# SO, SO, SO, SO LAZY
alias home='cd ~'
alias cls='clear'
alias clr='clear'
alias l='ls -lahpG'
alias lm='lsnew'
alias hosts='$EDITOR /etc/hosts'
alias vhosts='$EDITOR /Applications/MAMP/conf/apache/extra/httpd-vhosts.conf'
alias profile='$EDITOR ~/.bash_profile'
alias aliases='$EDITOR ~/.bash_aliases'
alias top='top -ocpu'
alias back='cd $OLDPWD'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ConsumerAffairs
# changes to repos root directory
alias ca='cd ~/Sites/consumeraffairs'
alias fe='cd ~/Sites/frontend'
alias sg='cd ~/Sites/styleguide'
alias mt='cd ~/Sites/thewiz'
alias bm='cd ~/Sites/buildmodule'

# frontends
alias sgfe='cd ~/Sites/styleguide/frontend'
alias mtfe='cd ~/Sites/thewiz/frontend'

# functions
alias work='startWorking'
alias kca='kca'

# shortcuts
alias runserver='./manage.py runserver'
alias migrate='./manage.py migrate'
alias collect='./manage.py collectstatic -c --noinput'
alias collectandrun='./manage.py collectstatic -c --noinput && ./manage.py runserver'
alias flush='redis-cli flushall'
alias nopyc='find . -name "*.pyc" -delete'
alias bt='gulp b && gulp t'
alias repos='update_repos'