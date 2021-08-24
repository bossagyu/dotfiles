DOTFILES_ROOT=`cd $(dirname $0); pwd`

#ln -siv $DOTFILES_ROOT/tmux/.tmux.conf $HOME/.tmux.conf
#ln -siv $DOTFILES_ROOT/git/.gitconfig $HOME/.gitconfig
ln -siv $DOTFILES_ROOT/zsh/.zshrc $HOME/.zshrc

mkdir -p $HOME/.zsh
cd $HOME/.zsh && curl -o git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

# fzfのインストール
if [ ! -d $HOME/.fzf ]; then 
    git clone https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
else
    echo skip fzf install
fi 

# cdrに必要なディレクトリを作成する
if [ ! -d $HOME/.fzf ]; then 
    mkdir -p .cache/shell/chpwd-recent-dir
else
    echo skip mkdir cdr
fi

# zsh-completionsのインストール
brew install zsh-completions
