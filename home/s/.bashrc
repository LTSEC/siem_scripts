# .bashrc
# Source global definitions
if [ -f /etc/.bashrc ]; then
	. /etc/.bashrc;
fi
# if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
#         source /etc/profile.d/vte.sh
# fi
source ~/.scripts/git-completion.sh
source ~/.scripts/git-prompt.sh
source ~/.scripts/docker-enter-completion.bash
#export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
export PS1='[\u@\h \[\e[31m\]\W\[\e[m\]$(__git_ps1 " (%s)")]\$ '
alias docker-enter="sudo /usr/local/bin/docker-enter"
alias ls="ls --color"
alias ll="ls -lAh"
alias swork="cd ~/Projects/Radar/"
alias gwork="cd ~/Projects/General/"
alias gs="git status"
alias gf="git fetch --all"
alias grm="git fetch --all; git reset origin/master --hard"
alias cmg="git commit -m"
alias cag="git commit -a"
alias cmag="git commit -am"
#alias chg="git checkout"
alias go="git checkout"
__git_complete go _git_checkout
alias gp="git push"
__git_complete gp _git_push
export TERMINAL=tilix

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=2000
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

##
# Creates an alias called "git hist" that outputs a nicely formatted git log.
# Usage is just like "git log"
# Examples:
#   git hist
#   git hist -5
#   git hist <branch_name>
#   git hist <tag_name> -10
##
git config --global alias.hist "log --graph --pretty=format:'%Cred%h%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset -%C(yellow)%d%Creset' --abbrev-commit"
git config --global merge.tool meld

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
