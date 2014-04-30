set nocompatible " vi互換を無効
set noswapfile "swapファイルを作らない
set nowritebackup "バックアップファイルを作成しない
set nobackup "バックアップを無効

"----------------------------
" Vundle
"----------------------------
filetype off " required!

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

" ファイル形式での判別をON
filetype indent plugin on
filetype indent on

" ----------------------------
" display
" ----------------------------
" 色付けON
syntax enable
"colorscheme jellybeans
colorscheme molokai
set t_Co=256

set number " show line number
set showmode " show mode
set title " show filename
set list " show eol,tab,etc...
set listchars=tab:>-,trail:-,extends:>,precedes:< " eol:$

" ----------------------------
set hidden "バッファ切り替えを利用、編集中に他のファイルを表示
set wildmenu "ワイルドメニュー有効
set showcmd "タイプ途中のコマンドを画面最下行に表示
set hlsearch "検索語の強調表示（C-Lで解除）

" ----------------------------
" 検索時に大文字・小文字を区別しない。ただし、検索後に大文字小文字が
" 混在しているときは区別する
set ignorecase
set smartcase
set autoindent "オートインデントON
set autoread
set nostartofline "移動などを使った時に行頭に移動しない（Shift+Gとか？）
set ruler "ルーラー表示（画面最下部）
set clipboard=unnamed,autoselec " share OS clipboard

" オートインデント、改行、インサートモード開始直後にバックスペースキーで削除できるようにする。
set backspace=indent,eol,start
set laststatus=2 "ステータスラインを常に表示する
set confirm "バッファが変更されている場合保存するか尋ねる
set visualbell "beepの代わりにビジュアルベル（画面フラッシュ）を使う
set t_vb= "ビジュアルベル無効
set mouse=a "全モード時マウス有効
set cmdheight=1 "コマンドラインの高さを2行に
set number "行番号表示
set notimeout ttimeout ttimeoutlen=200 "キーコードはすぐにタイムアウト。マッピングはタイムアウトしない（？）
set pastetoggle=<F11>
set splitbelow "新しいウィンドウを下に開く

" ----------------------------
" タブ文字の代わりにスペース2個を使う場合の設定。
" この場合、'tabstop'はデフォルトの8から変えない。 =>
" 2に変更する場合はコメント解除
set shiftwidth=2
set softtabstop=2
set expandtab
"set tabstop=2 "タブ1辺りのスペース文字数

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
"<Leader>をスペースに"
let mapleader=" "
" 入力モード中に素早くJJと入力した場合はESCとみなす
inoremap jj <Esc>
" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>
" 他の分割画面を閉じる
nnoremap <Leader>o :only<CR>
nnoremap <Leader>r :QuickRun<CR>

" ----------------------------
" auto command
" ----------------------------
augroup BufferAu
autocmd!
" change current directory
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

