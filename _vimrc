set nocompatible
set noswapfile
set nowritebackup
set nobackup

"----------------------------
" Vundle
"----------------------------
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle'))
endif

NeoBundle 'Shougo/neobundle.vim'

" ------- Bundles here -------
NeoBundle 'molokai'
NeoBundle 'fugitive.vim'
NeoBundle 'surround.vim'
NeoBundle 'mru.vim'
NeoBundle 'The-NERD-tree'
NeoBundle 'lightline.vim'
NeoBundle 'EasyMotion'
NeoBundle 'L9'
NeoBundle 'FuzzyFinder'
NeoBundle 'thinca/vim-quickrun'

" Ruby/Rails
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'
NeoBundle 'snipMate'
" ----------------------------

filetype indent plugin on
filetype indent on

" ----------------------------
" display
" ----------------------------
syntax enable
colorscheme molokai
set t_Co=256

set number
set showmode
set title
set list
set listchars=tab:>-,trail:-,extends:>,precedes:< " eol:$

" ----------------------------
set hidden
set wildmenu
set showcmd
set hlsearch

" ----------------------------
set ignorecase
set smartcase
set autoindent
set autoread
set nostartofline
set ruler
set clipboard=unnamed,autoselec
set backspace=indent,eol,start
set laststatus=2
set confirm
set visualbell
set t_vb=
set mouse=a
set cmdheight=1
set number
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>
set splitbelow

" ----------------------------
set shiftwidth=2
set softtabstop=2
set expandtab
"set tabstop=2

" ----------------------------
highlight link ZenkakuSpace Error
match ZenkakuSpace /　/

" ----------------------------
" backup
" ----------------------------
" set backup
" set backupdir=~/.vim/vim_backup
" set swapfile
" set directory=~/.vim/vim_swap

" ----------------------------
" key map
" ----------------------------
let mapleader=" "
inoremap jj <Esc>
nmap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <Leader>o :only<CR>
nnoremap <Leader>r :QuickRun<CR>

" ----------------------------
" auto command
" ----------------------------
augroup BufferAu
autocmd!
autocmd BufNewFile,BufRead,BufEnter * if isdirectory(expand("%:p:h")) && bufname("%") !~ "NERD_tree" | cd %:p:h | endif
augroup END

" ----------------------------
" Plugin setting
" ----------------------------
" NERDTree
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeIgnore=['\.clean$', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=0
let g:NERDTreeMouseMode=2

" rails.vim
let g:rails_level=3

" Quickrun
augroup RSpec
autocmd!
autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END
let g:quickrun_config = {}
let g:quickrun_config = {'*': {'split': ''}}
let g:quickrun_config = {'*': {'hook/time/enable': '1'},}
let g:quickrun_config['ruby.rspec'] = {'command': "spec", 'cmdopt': "-l {line('.')} -cfs"}

" lightline
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ ['yuno'], [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component': {
        \   'yuno': 'X / _ / X <'
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
