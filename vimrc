autocmd!
set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'thoughtbot/vim-rspec'
Plug 'kien/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
call plug#end()

filetype plugin indent on

set background=dark
colorscheme Tomorrow-Night
syntax enable
syntax sync fromstart

let mapleader = " "

set exrc

au BufWritePre * :%s/\s\+$//e
au BufWritePost .vimrc so $MYVIMRC
" Make those debugger statements painfully obvious
au BufEnter *.rb syn match error contained "\<binding.pry\>"
au BufEnter *.rb syn match error contained "\<debugger\>"

let g:netrw_liststyle = 0
let g:airline#extensions#tabline#enabled = 1
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

"save pressing Esc twice
map <Esc><Esc> :w<CR>

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

map <Leader>bd :bd<CR>

nnoremap <Tab><Tab> :Explore<CR>

set ttyfast
set ttyscroll=3
set lazyredraw
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set nobackup
set number      "show line number
set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom
set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default
set noro
set encoding=utf-8
set colorcolumn=120
set showmatch
set noswapfile
set backspace=indent,eol,start
