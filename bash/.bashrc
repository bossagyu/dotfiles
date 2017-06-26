PATH=~/bin:/usr/bin:$PATH
export PATH

#---------------------------------------
# prompt
#---------------------------------------
if [ "x$YROOT_NAME" != "x" ]; then
  PS1='[\[\e[0;36m\]\[$(date +"%Y/%m/%d %k:%M:%S")\] \[\e[1;00m\]\[\e[1;34m\w\[\e[0;35m\]$(__git_ps1)\]\[\e[1;00m]\]\n\[\e[0;32m\]\u @\h->$YROOT_NAME \[\e[1;35m=>\]\[\e[1;00m\]'
else
  PS1='[\[\e[0;36m\]\[$(date +"%Y/%m/%d %k:%M:%S")\] \[\e[1;00m\]\[\e[1;34m\w\[\e[0;35m\]$(__git_ps1)\]\[\e[1;00m]\]\n\[\e[0;32m\]\u @\h \[\e[1;35m=>\]\[\e[1;00m\]'
fi

#-------------alias--------------------
alias ls="ls -CF"
alias cls="clear;ls"
alias vb="vim ~/.bashrc;source ~/.bashrc"
alias ll="ls -l"
alias suvim="sudo vim -u ~/.vimrc"
alias ssh="ssh -A"
alias tmux="tmux -2"

# ssh 時に新規ウィンドウを作る
#
# git-completion.bash / git-prompt.sh
#
if [ -f ~/dotfiles/git/git-completion.bash ]; then
    source ~/dotfiles/git/git-completion.bash
fi
if [ -f ~/dotfiles/git/git-prompt.sh ]; then
    source ~/dotfiles/git/git-prompt.sh
fi
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto
