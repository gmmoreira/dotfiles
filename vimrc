" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!mkdir -p ~/.vim/autoload'
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')
  Plug 'altercation/vim-colors-solarized'
  Plug 'airblade/vim-gitgutter'
  Plug 'vim-airline/vim-airline'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'rking/ag.vim'
  Plug 'elixir-lang/vim-elixir'
  Plug 'vim-ruby/vim-ruby'
  Plug 'guns/vim-clojure-static'
  Plug 'tpope/vim-salve'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-fireplace'
  Plug 'thoughtbot/vim-rspec'
  Plug 'kien/rainbow_parentheses.vim'
  Plug 'tpope/vim-endwise'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
call plug#end()

" Colorscheme
syntax enable
filetype plugin indent on
set background=dark
let t_Co=16
let g:solarized_termcolors=16
colorscheme solarized

set nocompatible
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
set nobackup
set number      "show line number
set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom
set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default
set noro

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

let mapleader=" "

" airline
let g:airline#extensions#tabline#enabled = 1

" git-gutter
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" NERDTree
nmap <leader>n :NERDTreeToggle<cr>

" buffers
" open a new empty buffer
nmap <leader>N :enew<cr>

" move to the next buffer
nmap <leader>l :bnext<CR>

" move to the previous buffer
nmap <leader>h :bprevious<CR>

" close the current buffer and move to the previous one
nmap <leader>bq :bp <BAR> bd #<CR>

" show all open buffers and their status
nmap <leader>bl :ls<CR>

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" airline
let g:airline#extensions#tabline#enabled = 1

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
