" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Set Dein base path (required)
let s:dein_base = '/home/kmasuda/.cache/dein'

" Set Dein source path (required)
let s:dein_src = '/home/kmasuda/.cache/dein/repos/github.com/Shougo/dein.vim'

" Set Dein runtime path (required)
execute 'set runtimepath+=' . s:dein_src

" Call Dein initialization (required)
call dein#begin(s:dein_base)

call dein#add(s:dein_src)

" Your plugins go here:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/vimproc')
call dein#add('tpope/vim-fugitive')
call dein#add('Lokaltog/vim-easymotion')
call dein#add('scrooloose/nerdtree')
call dein#add('h1mesuke/vim-alignta')
call dein#add('vim-scripts/L9')
call dein#add('vim-scripts/rails.vim')
call dein#add('thinca/vim-quickrun')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neocomplcache')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('ujihisa/unite-colorscheme')
call dein#add('Lokaltog/vim-powerline')
call dein#add('vim-scripts/ZoomWin')
call dein#add('vim-scripts/neco-look')
call dein#add('vim-scripts/ack.vim')
call dein#add('vim-scripts/errormarker.vim')
call dein#add('vim-scripts/taglist.vim')
call dein#add('vim-scripts/dbext.vim')
call dein#add('glidenote/memolist.vim')
call dein#add('kien/ctrlp.vim')
call dein#add('jnurmine/Zenburn')
call dein#add('nanotech/jellybeans.vim')
call dein#add('junegunn/fzf', { 'build': './install', 'merged': 0 })
call dein#add('junegunn/fzf.vim')
call dein#add('github/copilot.vim')

" Finish Dein initialization (required)
call dein#end()

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
  syntax on
endif

" Uncomment if you want to install not-installed plugins on startup.
if dein#check_install()
 call dein#install()
endif

" My Setting
set t_Co=256
colorscheme jellybeans

" ファイルに変更があった際、
" バッファを閉じようとした時の自動書き込みOFF
" 書き込み確認が表示される設定
set noautowrite

" 最終行を2行にして
" ステータスラインを表示する
set laststatus=2

" シンタックスを有効に
syntax on
" BackSpaceで行の先頭やインデントを削除できるように
set backspace=indent,eol,start
" 行数を表示
set number
" 検索結果をハイライトする
set hlsearch
" gfの挙動変更
nnoremap gf :vertical topleft new <cfile><CR>
" for dropbox
set directory=~/.vim/swap

" encoding "{{{2
" ref: http://github.com/kana/config/blob/master/vim/dot.vimrc
" ref: http://d.hatena.ne.jp/ka-nacht/20080220/1203433500
set encoding=utf-8

if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'

  " Does iconv support JIS X 0213 ?
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213,euc-jp'
    let s:enc_jis = 'iso-2022-jp-3'
  endif

  " Make fileencodings
  let &fileencodings = 'ucs-bom'
  if &encoding !=# 'utf-8'
    let &fileencodings = &fileencodings . ',' . 'ucs-2le'
    let &fileencodings = &fileencodings . ',' . 'ucs-2'
  endif
  let &fileencodings = &fileencodings . ',' . s:enc_jis

  if &encoding ==# 'utf-8'
    let &fileencodings = &fileencodings . ',' . s:enc_euc
    let &fileencodings = &fileencodings . ',' . 'cp932'
  elseif &encoding =~# '^euc-\%(jp\|jisx0213\)$'
    let &encoding = s:enc_euc
    let &fileencodings = &fileencodings . ',' . 'utf-8'
    let &fileencodings = &fileencodings . ',' . 'cp932'
  else  " cp932
    let &fileencodings = &fileencodings . ',' . 'utf-8'
    let &fileencodings = &fileencodings . ',' . s:enc_euc
  endif
  let &fileencodings = &fileencodings . ',' . &encoding

  unlet s:enc_euc
  unlet s:enc_jis
endif

" 日本語を含まない場合は fileencoding に encoding を使うようにする
" http://www.kawaz.jp/pukiwiki/?vim
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

" plugins "{{{1
" errormarker.vim "{{{2
set errorformat&
let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat
set makeprg=LANGUAGE=C\ make
let g:errormarker_errorgroup = "ErrorLine"
highlight ErrorLine ctermbg=52 guibg=#5F0000
let g:errormarker_warninggroup = "WarningLine"
highlight WarningLine ctermbg=17 guibg=#00005F

" vim-ruby "{{{2
let g:rubycomplete_rails = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_buffer_loading=1
let g:rubycomplete_classes_in_global=1
let g:rubycomplete_rails=1

" fuf.vim "{{{2
" enable FufMruFile
let g:fuf_modesDisable = ['mrucmd']
let g:fuf_mrufile_maxItem = 10000
nmap fb :Buffers<CR>
nmap ff :Files<CR>

" neocomplecache "{{{2
" http://d.hatena.ne.jp/cooldaemon/20090807/1249644264
" http://vim-users.jp/2009/07/hack-49/
let g:NeoComplCache_EnableAtStartup = 0
let g:NeoComplCache_SmartCase = 1
let g:NeoComplCache_EnableCamelCaseCompletion = 1
let g:NeoComplCache_EnableUnderbarCompletion = 1
let g:NeoComplCache_KeywordCompletionStartLength = 4
let g:NeoComplCache_MinKeywordLength = 3
let g:NeoComplCache_MinSyntaxLength = 3

" taglist.vim "{{{2
nnoremap <silent> tt :TlistToggle<CR>
nnoremap <silent> t :<C-u>Tlist<CR>

" quickrun.vim "{{{2
if !exists('g:quickrun_config')
	let g:quickrun_config = {}
	let g:quickrun_config.c = {'command' : 'make',
				\ 'exec': ['%c -s check' ] }
endif

" dbext.vim "{{{2
let g:dbext_default_type = 'MYSQL'
let g:dbext_default_user = 'user'
let g:dbext_default_passwd = 'pass'
let g:dbext_default_dbname = 'dbname'

" etc "{{{1
"
" ビープ音
set visualbell t_vb=

" 検索大文字小文字無視
set ignorecase
" 検索で大文字が入っている場合は大文字小文字一致
set smartcase
" indent
set smartindent
set autoindent
" タブ幅
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set nowrapscan
"set ambiwidth=double
set showcmd
set showmode
" useopen	= ファイルを開こうとした際、
" 			  既にウィンドウに表示されている場合
" 			  新たにバッファを作らずに
" 			  開かれているウィンドウにフォーカスする
" split		= quickfixでファイルを選択した際に
" 			  ファイルが開かれていない場合は
" 			  ウィンドウを分割しファイルを表示する
" set switchbuf=split,useopen

" コマンドライン補完する時に強化されたものを使う
set wildmenu
nnoremap <silent> <Space>a :!cscope -Rb -I$HOME/opt/include<CR>
nnoremap <silent> <Space>c :!ctags -R --exclude=data<CR>
nnoremap <silent> <Space>g :!gtags -v<CR>
nnoremap <silent> <Space>m :make<CR>
nnoremap <silent> <C-u> :e ++enc=utf8<CR>

nnoremap <silent> <C-n> :tabnext<CR>
nnoremap <silent> <C-p> :tabprevious<CR>
nnoremap <silent> <Space>t :tabnew<CR>

" cscope "{{{2
if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=0
	set cst
	set nocsverb
	if filereadable("cscope.out")
		cs add cscope.out
	elseif $CSCOPE_DB !=""
		cs add $CSCOPE_DB
	endif
	set csverb
endif
map <C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>

" gf による検索パスの追加
if has("autocmd")
	autocmd FileType c :setlocal path+=$HOME/opt/include,src
	autocmd FileType cpp :setlocal path+=$HOME/opt/include,src
endif

" gauche "{{{2
" if has("autocmd")
"	autocmd FileType scheme :let is_gauche=1
" endif

" END "{{{1
" <a href="http://www.vim.org/">www.vim.org</a>
" vim: foldmethod=marker

