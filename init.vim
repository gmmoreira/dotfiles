autocmd!

call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch'

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'ntpeters/vim-better-whitespace'

" Initialize plugin system
call plug#end()

let mapleader = ' '

augroup 'whitespace'
  autocmd!
  autocmd BufWrite * StripWhitespace
augroup end

" Move line up
nmap <C-Up> ddkP
" Move line down
nmap <C-Down> ddp

nmap <ESC> :nohl<CR>

tnoremap <Esc> <C-\><C-n>

nmap <leader>mrrf :!bundle exec rubocop %<CR>
nmap <leader>mrrF :!bundle exec rubocop -a %<CR>
nnoremap <leader>fs :w<CR>
inoremap jk <ESC>
inoremap <ESC> <nop>
nnoremap <leader>pt :NERDTreeToggle<CR>
nnoremap <leader>mta :A<CR>
nnoremap <leader>bb :ls<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>ff :FZF<CR>
nnoremap <leader>fed :e $MYVIMRC<CR>
nnoremap <leader>feR :so $MYVIMRC<CR>
nnoremap <leader>fD :bwipeout<CR>
nnoremap <leader>wd <C-w>q
nnoremap <leader>qq :wqa<CR>

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

set expandtab
set shiftwidth=2
set softtabstop=2
set tags=./tags;
