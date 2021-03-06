autocmd!

call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

Plug 'ntpeters/vim-better-whitespace'
Plug 'chriskempson/base16-vim'

Plug 'ludovicchabant/vim-gutentags'
Plug 'justinmk/vim-dirvish'

" Initialize plugin system
call plug#end()

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

let mapleader = ' '

let g:strip_whitespace_on_save = 1
" augroup 'whitespace'
"   autocmd!
"   autocmd BufWrite * StripWhitespace
" augroup end

nmap <ESC> :nohl<CR>
inoremap jk <ESC>
tnoremap <Esc> <C-\><C-n>

nmap <leader>mrrf :!bundle exec rubocop %<CR>
nmap <leader>mrrF :!bundle exec rubocop -a %<CR>
nmap <leader>mtb :Rails<CR>
nnoremap <leader>fs :w<CR>
nnoremap <leader>pt :NERDTreeToggle<CR>
nnoremap <leader>mt<TAB> :A<CR>
nnoremap <leader>mx' cs"'
nnoremap <leader>mx" cs'"
nnoremap <leader>bb :ls<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fR :Rename<SPACE>
nnoremap <leader>fed :e $MYVIMRC<CR>
nnoremap <leader>feR :so $MYVIMRC<CR>
nnoremap <leader>fD :bwipeout<CR>
nnoremap <leader>wd <C-w>q
nnoremap <leader>qq :wqa<CR>
vmap <leader>xa :EasyAlign<CR>
vmap <leader>xs :sort<CR>
nnoremap <leader>wc :Goyo<CR>
nmap <Leader>l <Plug>(Limelight)
xmap <Leader>l <Plug>(Limelight)

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

set expandtab
set shiftwidth=2
set softtabstop=2
set tags=./tags,tags,.git/tags
set clipboard+=unnamedplus

if executable('rg')
  " --files: List files that would be searched but do not search
  " --no-ignore: Do not respect .gitignore, etc...
  " --hidden: Search hidden files and folders
  " --follow: Follow symlinks
  " --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)

  let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore --hidden --follow -g "!.git/*" -g "!vendor/gems/*" -g "!vendor/bundle/*" -g "!tmp/cache/"'
  set grepprg=rg

  " Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
  command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
        \   <bang>0 ? fzf#vim#with_preview('up:60%')
        \           : fzf#vim#with_preview('right:50%:hidden', '?'),
        \   <bang>0)

  " Likewise, Files command with preview window
  command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
endif
