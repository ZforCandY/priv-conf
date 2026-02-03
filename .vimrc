filetype plugin indent on
syntax on
colorscheme lunaperche

autocmd! bufwritepost .vimrc source %
set pastetoggle=<F2>
nnoremap ; :

set belloff=all
set nocompatible

set number
set relativenumber
set showmode
set showcmd
set encoding=utf-8
set t_Co=256
set modeline
set ttyfast
set lazyredraw

set autoindent
set expandtab
set tabstop =4
set shiftwidth =4

set incsearch
set ignorecase
set smartcase

set spell spelllang=en_us

set history=666
set undofile
set clipboard+=unnamed
set go+=a
set listchars=tab:»Θ,trail:Θ
set list

set wildmenu
set wildmode=longest:list,full

set backup
set backupdir   =$HOME/.vim/.backup//
set backupext   =-vimbackup
set backupskip  =
set directory   =$HOME/.vim/.swap//
set updatecount =100
set undofile
set undodir     =$HOME/.vim/.undo//
set viminfo     ='100,n$HOME/.vim/.viminfo//
