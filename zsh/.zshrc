export PATH=/usr/local/bin:$PATH

#fzfを読み込む
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# cdrを有効化 
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-pushd true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"

# 色を使用
autoload -Uz colors
colors

# 他のターミナルとヒストリーを共有
setopt share_history

# 自動でpushdを実行
setopt auto_pushd

# コマンドミスを修正
setopt correct

# 日本語ファイルを表示可能にする
setopt print_eight_bit

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

# 同じコマンドをhisotryに残さない
setopt hist_ignore_all_dups

# gitのprompt表示用のshellを読み込む
source ~/.zsh/git-prompt.sh
autoload -Uz compinit && compinit

# 表示オプション
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto
setopt prompt_subst

# 通常のプロンプト
PROMPT='%{${fg[green]}%}[%D %*%\]${fg[blue]} %~
%{${fg[magenta]}%}=> '

# プロンプトの右側
RPROMPT='%F{red}$(__git_ps1 "%s" )%f'


#-------------alias--------------------
alias ls="ls -CF"
alias ll="ls -l"
alias suvim="sudo vim -u ~/.vimrc"
alias ssh="ssh -A"
alias tmux="tmux -2"


#------------ fzf ----------------------
function fsnip() {
  print -z $(cat ~/.zsh_snips | fzf)
}

# コマンド履歴
# CTRL-R - Paste the selected command from history into the command line
function fzf-history-widget() {
    local tac=${commands[tac]:-"tail -r"}
    BUFFER=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) |
        sed 's/ *[0-9]*\** *//' |
        eval $tac | awk '!a[$0]++' |
        fzf --prompt="History> " +s)
    CURSOR=$#BUFFER
}
zle     -N   fzf-history-widget
bindkey '^R' fzf-history-widget

# ヒストリを利用したディレクトリ移動
function hd () {
    local selected_dir=$(cdr -l |
        sed 's/^[^ ][^ ]*  *//' |
        sed 's/\\ / /g' |
        sed 's/\\(/(/g' |
        sed 's/\\)/)/g' |
        fzf +s --prompt="cd> ")
    selected_dir=${selected_dir/#\~/$HOME}
    if [ -n "$selected_dir" ]; then
        cd "$selected_dir"
    fi
}

# ブランチの切り替え
function fbr() {
    local branches branch
    branches=$(git branch | grep -v "^* " | sed "s/^  //") &&
        branch=$(echo "$branches" | fzf +m --prompt="Branch> " --preview="git log --color=always {}") &&
        git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# タグやリモートブランチも含めてチェックアウトする
function fco() {
    local tags branches target
    tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
    branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
    target=$(
    (echo "$branches"; echo "$tags") |
    fzf --prompt="Checkout> " --no-hscroll --ansi +m -d "\t" -n 2) || return
    git checkout $(echo "$target" | awk '{print $2}')
}

# 履歴からsshする
function fssh() {
  local host="$(cat ~/.ssh/known_hosts | awk '{split($1, s, ","); print s[1]}' | fzf)"
  if [ -n "$host" ] ; then
    print -z ssh "$host"
  fi
}

# fzfを利用したコマンドを表示する
function fzf_commands() {
    echo hd   履歴から移動
    echo fbr  ブランチの切り替え
    echo fco  タグ・リモートブランチを含めてチェックアウト
    echo fssh 履歴からsshする
}
