" 表示系設定
set number		" 行番号の表示
set title		" ターミナルのタイトルをセット
set cursorline		" カーソル行に背景色をつける
set cursorcolumn	" カーソル位置のカラムの背景色を変更
set showmatch		" 対応する括弧を強調表示
set matchtime=5		" 対応する括弧をより素早く表示
"set list		" 不可視文字を表示
set ruler		" ルーラーを表示

" 検索系設定
set hlsearch		" 検索文字列をハイライト表示
set incsearch		" インクリメンタルサーチ
set ignorecase		" 大小文字を区別しない
set smartcase		" 大小文字を混在させた検索のみ大小文字を区別
set gdefault 		" 置換時のgオプションをデフォルト有効に

" その他の設定
set autoread		" 外部でファイル変更された場合は読み直す
set mouse=a		" マウス入力を受け付ける
set history=10000	" コマンドラインの履歴保持
set visualbell t_vb=	" ビープ音を無効
set noerrorbells 	" エラー時もビープ音を無効
set backspace=2		" Backspace定義 indent,eol,start
set hidden		" バッファ移動時に変更分を自動的に隠しバッファに移動
set nocompatible	" vi互換動作を無効

" Powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" Keymap
"" CommandLine Mode
""" コマンド履歴利用時にカーソルキーを使わず、かつ履歴フィルタを有効にする
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
""" アクティブなファイルが含まれているディレクトリを手早く展開
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'


"" Normal Mode
""" バッファリスト移動用 関連性があるコマンドなので[]でまとめる
nnoremap <silent> [b :bprevious
nnoremap <silent> ]b :bnext
nnoremap <silent> [B :bfirxt
nnoremap <silent> ]B :blast
""" F5でctagsを実行
nnoremap <f5> :!ctags -R<R>

"" Visual Mode
""" 選択範囲を*や#で検索できるようにする
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

"" Insert Mode
imap <c-h> <Left>
imap <c-j> <Down>
imap <c-k> <Up>
imap <c-l> <Right>
imap <c-n> <Esc>o


python import markdown
let g:evervim_devtoken=$EVERNOTE_TOKEN

" NeoBundle
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

"" NeoBundle Plugin start

NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'kakkyz81/evervim'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'bronson/vim-trailing-whitespace'

"" NeoBundle Plugin end
NeoBundleCheck
call neobundle#end()
filetype plugin indent on

set t_Co=256
syntax on
colorscheme jellybeans

"" Mark settings
"if !exists('g:markrement_char')
"    let g:markrement_char = [
"    \     'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
"    \     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
"    \ ]
"endif
"nnoremap <silent>m :<C-u>call <SID>AutoMarkrement()<CR>
"function! s:AutoMarkrement()
"    if !exists('b:markrement_pos')
"        let b:markrement_pos = 0
"    else
"        let b:markrement_pos = (b:markrement_pos + 1) % len(g:markrement_char)
"    endif
"    execute 'mark' g:markrement_char[b:markrement_pos]
"    echo 'marked' g:markrement_char[b:markrement_pos]
"endfunction

"" Markdown Firefox Preview
au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a Firefox'

"" Neocomplete vim settings
if filereadable(expand('~/.neocomplete'))
    source ~/.neocomplete
endif

"" EasyMotion
let g:EasyMotion_leader_key="<Space>"
" ホームポジションに近いキーを使う
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcv'
" 1 ストローク選択を優先する
let g:EasyMotion_grouping=1
" カラー設定変更
hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionShade  ctermbg=none ctermfg=blue

" matchit
runtime macros/matchit.vim

" 選択範囲を貼り付け可能に
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" quickfixリストから各ファイルを引数リストにコピーする
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" 80カラムに印を設定
if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=9
endif

let g:unite_source_history_yank_enable = 1
try
  let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
catch
endtry
nnoremap <space><space> :split<cr> :<C-u>Unite -start-insert file_rec/async<cr>
:nnoremap <space>r <Plug>(unite_restart)
