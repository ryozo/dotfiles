" Display settings
set number		" Show line number
set title		" Set terminal title
set cursorline		" Add a background color to the cursor line
set cursorcolumn	" Add a background color to the cursor column
set showmatch		" Highlight the corresponding parentheses
set matchtime=5		" Show corresponding parentheses quickly
"set list		" Show invisible characters
set ruler		" Show ruler

" GVim settings
set guioptions-=m	" Hide the menu bar in the GVim
set guioptions-=T	" Hide the tool bar in the GVim
set guioptions-=r	" Hide the right scroll bar in the GVim
set guioptions-=R	" Hide the right scroll bar in the GVim
set guioptions-=l	" Hide the left  scroll bar in the GVim
set guioptions-=L	" Hide the left  scroll bar in the GVim
set guioptions-=b	" Hide the horizontal scroll bar in the GVim
set guifont=Ricty\ Diminished\ for\ Powerline\ Regular\ 10	" GUI font and size

" Search settings
set hlsearch		" Highlight search string
set incsearch		" Enable incremental search
set ignorecase		" Search case insensitive
set smartcase		" Distinguish only when mixing uppper and lowercase letters
set gdefault 		" Enable replacement 'g' option by default

" Other settings
set autoread		" If the file has been changed externally, read it again
set mouse=a		" Accept mouse input
set history=10000	" Save command line history
set visualbell t_vb=	" Disable beep
set noerrorbells 	" Disable beep on error occasion
set backspace=2		" Declare backspace (indent,eol,start)
set hidden		" Move the buffer even if there are unsaved changes
set nocompatible	" Disable vim compatible behavior
set shiftwidth=4	" Width displaced by automatic indentation
set spell		" Enable vim's spelling checker
set spelllang=en,cjk	" Exclude errors in JP, with spelling checker in English

" Powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" Setting up autocmd
augroup vimrc_loading
  autocmd!
  autocmd BufRead *.c let b:compiler = 'gcc'
  autocmd BufRead *.cpp let b:compiler = 'g++'
  autocmd BufReadPost,BufNewFile,Syntax * call s:SpellConf()
augroup END

" Leader key
let mapleader = "\<Space>"

" Keymap
"" CommandLine mode
""" Enable history filter, and don't use cursor keys when using command history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
""" Quickly expand directory containing active files
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'


"" Normal mode
""" Commands for moving the buffer list
nnoremap <silent> [b :bprevious
nnoremap <silent> ]b :bnext
nnoremap <silent> [B :bfirxt
nnoremap <silent> ]B :blast
nnoremap <silent> <F2> :bprevious<cr>
nnoremap <silent> <F3> :bnext<cr>
""" Execute ctags with f5
nnoremap <f5> :!ctags -R<CR>
""" Separate window
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
""" Toggle comment
nmap <Leader>c <Plug>(caw:i:toggle)
""" Quick highlight
nmap <Leader>m <Plug>(quickhl-manual-this)
nmap <Leader>M <Plug>(quickhl-manual-reset)
nmap <Leader>j <Plug>(quickhl-cword-toggle)
""" Key mapping similar to intellij idea
nmap <ESC><Left> <M-Left>
nmap <ESC><Right> <M-Right>
nnoremap <M-Left> <C-o>
nnoremap <M-Right> <C-i>
nnoremap <C-b> <C-]>
""" Define code exec and debugging settings with keybindings similar to idea
nnoremap <expr> <S-F9> ":w <CR> :!".b:compiler." -g -Wall % -o %< <CR> :VBGstartGDB %< <CR>"
nnoremap <expr> <S-F10> ":w <CR> :!".b:compiler." -g -Wall % -o %< && ./%< <CR>"
nnoremap <F7> :VBGstepIn<CR>
nnoremap <F8> :VBGstepOver<CR>
nnoremap <F9> :VBGcontinue<CR>
nnoremap <S-F8> :VBGstepOut<CR>
nnoremap <C-d> :VBGtoggleBreakpointThisLine<CR>
nnoremap <C-F8> :VBGtoggleBreakpointThisLine<CR>
""" Define auto format keybinding
nnoremap <Leader><F3> :Autoformat<CR>

"" Visual Mode
""" Search selected range with '*' and '#'
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
""" Toggle comment
xmap <Leader>c <Plug>(caw:i:toggle)
""" Quick highlight
xmap <Leader>m <Plug>(quickhl-manual-this)
xmap <Leader>M <Plug>(quickhl-manual-reset)

"" Insert mode
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

"" NeoBundle plugin start

NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
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
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'simeji/winresizer'
NeoBundle 'int3/vim-extradite'
NeoBundle 'gregsexton/gitv'
NeoBundle 'vim-scripts/bufkill.vim'
NeoBundle 'vim-jp/cpp-vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'tyru/caw.vim'
NeoBundle 't9md/vim-quickhl'
NeoBundle 'idanarye/vim-vebugger'
NeoBundle 'Chiel92/vim-autoformat'

"" NeoBundle plugin end
NeoBundleCheck
call neobundle#end()
filetype plugin indent on

set t_Co=256
set background=dark
syntax on
colorscheme hybrid

" Mark settings
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

" Markdown Firefox preview
au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a Firefox'

" Neocomplete vim settings
if filereadable(expand('~/.neocomplete'))
    source ~/.neocomplete
endif

" EasyMotion
let g:EasyMotion_leader_key="<Space>"
"" Use a key close to home position
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcv'
"" Prioritize stroke selection
let g:EasyMotion_grouping=1
"" color settings
hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionShade  ctermbg=none ctermfg=blue

" matchit
runtime macros/matchit.vim

" Paste selection area
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" Copy each file from the quickfix list to the argument list
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" Set up a mark on the 80th column
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

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { "mode": "passive", "active_filetypes": ["h", "c", "hpp", "cpp"], "passive_filetypes": [] }
let g:syntastic_cpp_compiler_options = ' -std=c++11'

" Programmable words such as snake/camel case are excluded from spell check
" Referred to https://qiita.com/crispy/items/9a49d7dc792740f062ab
function! s:SpellConf()
  redir! => syntax
  silent syntax
  redir END

  if syntax =~? '/<comment\>'
    syntax spell default
    syntax match SpellMaybeCode /\<\h\l*[_A-Z]\h\{-}\>/ contains=@NoSpell transparent containedin=Comment contained
  else
    syntax spell toplevel
    syntax match SpellMaybeCode /\<\h\l*[_A-Z]\h\{-}\>/ contains=@NoSpell transparent
  endif

  syntax cluster Spell add=SpellNotAscii,SpellMaybeCode
endfunction

" CtrlP vim settings
let g:ctrlp_show_hidden = 1
