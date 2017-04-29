DOTFILES_ROOT=`cd $(dirname $0); pwd`

ln -siv $DOTFILES_ROOT/bash/.bash_profile $HOME/.bash_profile
ln -siv $DOTFILES_ROOT/bash/.bashrc $HOME/.bashrc
ln -siv $DOTFILES_ROOT/tmux/.tmux.conf $HOME/.tmux.conf
ln -siv $DOTFILES_ROOT/vim/.vim $HOME/.vim
ln -siv $DOTFILES_ROOT/vim/.vimrc $HOME/.vimrc
ln -siv $DOTFILES_ROOT/git/.gitconfig $HOME/.gitconfig
