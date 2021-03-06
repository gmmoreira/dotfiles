autocmd!
set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'flazz/vim-colorschemes'
Plug 'junegunn/vim-easy-align'
Plug 'kien/ctrlp.vim'
Plug 'luochen1990/rainbow'
Plug 'mileszs/ack.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-ruby/vim-ruby'
call plug#end()

filetype plugin indent on

syntax enable
syntax sync fromstart

if has('gui_running')
  set background=light
  colorscheme solarized
  set guifont=Source\ Code\ Pro
endif

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://sunaku.github.io/vim-256color-bce.html
  set t_ut=
endif

let mapleader = ' '

set exrc

au BufWritePre * :%s/\s\+$//e
au BufWritePost .vimrc so $MYVIMRC
" Make those debugger statements painfully obvious
au BufEnter *.rb syn match error contained "\<binding.pry\>"
au BufEnter *.rb syn match error contained "\<debugger\>"
au BufEnter *.js syn match error contained "\<debugger\>"

let g:netrw_liststyle = 0
let g:airline#extensions#tabline#enabled = 1
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

nnoremap <Leader>fu :CtrlPFunky<Cr>
nnoremap <Leader>tag :CtrlPTag<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

"save pressing Esc twice
map <Esc><Esc> :w<CR>


map <Leader>bd :bd<CR>
map <Leader>bp :bprevious<CR>
map <Leader>bn :bnext<CR>

" moving lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

nnoremap <Tab><Tab> :Explore<CR>

" Vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Raindow parenthesis
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" Support for alt command line https://github.com/uptech/alt
if executable('alt')
  " Run a given vim command on the results of alt from a given path.
  " See usage below.
  function! AltCommand(path, vim_command)
    let l:alternate = system("find . -path ./_site -prune -or -path ./target -prune -or -path ./.DS_Store -prune -or -path ./build -prune -or -path ./Carthage -prune -or -path tags -prune -or -path ./tmp -prune -or -path ./log -prune -or -path ./.git -prune -or -type f -print | alt -f - " . a:path)
    if empty(l:alternate)
      echo "No alternate file for " . a:path . " exists!"
    else
      exec a:vim_command . " " . l:alternate
    endif
  endfunction

  " Find the alternate file for the current path and open it
  nnoremap <leader>a :w<cr>:call AltCommand(expand('%'), ':e')<cr>
endif

if !has('nvim')
  set ttyscroll=3
endif
set ttyfast
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
set showmatch
set noswapfile
set backspace=indent,eol,start
set tags=.git/tags;

if !empty(glob('~/.vimrc.local'))
  source ~/.vimrc.local
endif
