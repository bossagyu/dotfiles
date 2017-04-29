
"基本オプション
set nocompatible
set number
set backspace=2
set autoindent
set showmatch
syntax on
"コーディングルール
set shiftwidth=4
set tabstop=4
set expandtab
set encoding=utf-8
set fileencodings=utf-8,euc-jp,cp932

"キー配置"
imap <c-j> <esc>
set list 
set listchars=tab:>-,trail:.,extends:>

runtime! userautoload/init/*.vim

"カラースキーマを指定
colorscheme molokai
set t_Co=256
