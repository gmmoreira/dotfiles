" Load vim-plug
if empty(glob("~/.nvim/autoload/plug.vim"))
    execute '!curl -fLo ~/.nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.nvim/plugged')
  Plug 'altercation/vim-colors-solarized'
  Plug 'airblade/vim-gitgutter'
  Plug 'Valloric/YouCompleteMe'
  Plug 'kien/ctrlp.vim'
  Plug 'rking/ag.vim'
call plug#end()

" Colorscheme
syntax enable
set background=dark
let g:solarized_termcolors=16
colorscheme solarized

set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
set nobackup
set number      "show line number
set cursorline  "highlight current line
set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom
set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

"key mapping for window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"save pressing Esc twice
map <Esc><Esc> :w<CR>

" Delete trailing white space on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()
