" hnishi's ~/.vimrc
" https://qiita.com/reireias/items/230c77b3ff5575832654#_reference-86bfd5c3dfeb524bbb09

syntax on
"set number
set incsearch   "real-time search
set smartcase   "Large letters will not be ignored but small letters ignored.
"set ignorecase

" enable highlight
" to see colors: `:so $VIMRUNTIME/syntax/colortest.vim`
set hlsearch   "highlight searched strings
hi Search ctermbg=grey

set laststatus=2
"最下ウィンドウにいつステータス行が表示されるかを設定する。
"0: 全く表示しない
"1: ウィンドウの数が2以上のときのみ表示
"2: 常に表示

set nocompatible
set showcmd   "show command

set background=dark
"値が "dark" のときは、Vimは暗い背景によく合う色を使おうとする。
"値が "light" のときは、Vimは明るい背景によく合う色を使おうとする。

set wildmenu
set ruler
" 対応する括弧を強調表示
set showmatch
"set cursorline " Underline
set encoding=utf-8

colorscheme peachpuff

"au BufWritePost * mkview
"autocmd BufReadPost * loadview

" タブキー押下時に挿入される文字幅を指定
"set softtabstop=4
" 省略されずに表示
set display=lastline
" タブ文字を CTRL-I で表示し、行末に $ で表示する
set list
" 行末のスペースを可視化
set listchars=tab:^\ ,trail:~
" 検索にマッチした行以外を折りたたむ(フォールドする)機能
set nofoldenable
" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>
" バッファスクロール
" set mouse=a " middle clickでpasteができなくなる

" 前回ファイルを保存したカーソルの位置を覚えておく (.vim ディレクトリを事前に作成)
" これを入れると挙動がおかしくなるのでオフにした。
" au BufWritePost * mkview
" autocmd BufReadPost * loadview

" 以下だと今のところ安定している
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

"""""""""""""""""""""""""
"      インデント
" https://qiita.com/ymiyamae/items/06d0f5ce9c55e7369e1f
""""""""""""""""""""""""
set autoindent          "改行時に前の行のインデントを計測
set smartindent         "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set cindent             "Cプログラムファイルの自動インデントを始める
set smarttab            "新しい行を作った時に高度な自動インデントを行う
set expandtab           "タブ入力を複数の空白に置き換える

set tabstop=2           "タブを含むファイルを開いた際, タブを何文字の空白に変換するか
set shiftwidth=2        "自動インデントで入る空白数
set softtabstop=0       "キーボードから入るタブの数

if has("autocmd")
  "ファイルタイプの検索を有効にする
  filetype plugin on
  "ファイルタイプに合わせたインデントを利用
  filetype indent on
  "sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtabの略
  autocmd FileType c           setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType js          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType zsh         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scala       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType json        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scss        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sass        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript  setlocal sw=4 sts=4 ts=4 et
endif

" vim-plug
" https://github.com/junegunn/vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" Plug 'vim/killersheep'
Plug 'vim-jp/autofmt'
Plug 'skanehira/preview-markdown.vim'
" Plug 'yasukotelin/shirotelin'
call plug#end()
" do :PlugInstall to install plugins

" for translate vimdoc
" https://github.com/vim-jp/vimdoc-ja-working/wiki/Guide
hi Ignore ctermfg=red
" autofmtの設定例
set formatexpr=autofmt#japanese#formatexpr()  " kaoriya版では設定済み
let autofmt_allow_over_tw=1                   " 全角文字がぶら下がりで1カラムはみ出すのを許可
" command gq to format by autofmt
" 以下のいずれかで、はみ出た部分の色を変えるのもよい。
syn match Error /\%>79v.*/
set cc=+1
" ファイル形式
" 文字コードは UTF-8
" 改行文字は UNIX 形式(\n)
set modifiable
set fileencoding=utf-8 fileformat=unix

" ファイル保存時に、不要な行末スペースを自動で削除
autocmd BufWritePre * :%s/\s\+$//ge

" tag jump
" https://qiita.com/crarrry/items/3887b084267d60d3c42f
nnoremap <C-]> g<C-]>
inoremap <C-]> <ESC>g<C-]>

" Tag jump (ctags -R -f .tags)
" Recommended: https://github.com/universal-ctags/ctags
" https://qiita.com/tutu/items/fbc4023ebc3004964e86
set tags=.tags;~ " search .tags up to $HOME
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>

" 括弧の補完
" https://babie.hatenablog.com/entry/20110130/1296348203
inoremap ( ()<ESC>i
inoremap { {}<ESC>i
inoremap [ []<ESC>i
inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap ` ``<ESC>i

