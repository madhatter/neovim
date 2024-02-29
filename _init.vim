set runtimepath^=~/.config/nvim

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'wincent/command-t'
call plug#end()

source ~/.nvimrc
