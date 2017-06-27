""""""""""""""""""""""""""""
" neobundle.vim
" インストール手順
"   % mkdir -p ~/.vim/bundle
"   % git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
"   % git clone https://github.com/Shougo/vimproc ~/.vim/bundle/vimproc
"
"vimを立ち上げて
":NeoBundleInstall
"を実行するとプラグインがインストールされる
""""""""""""""""""""""""""""

set nocompatible               " be iMproved
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  " neobundle#rc is deprecated. So using neobundle#begin and end.
  " cf. http://qiita.com/musclemikiya/items/58edc801264aca151446
  " call neobundle#rc(expand('~/.vim/bundle/'))
  call neobundle#begin(expand('~/.vim/bundle/'))
endif

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

""""""""""""""""""""""""""""
" plugins
""""""""""""""""""""""""""""
NeoBundleCheck

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

if has("lua")
  NeoBundleLazy 'Shougo/neocomplete', { 'autoload' : {
        \   'insert' : 1,
        \ }}
endif

NeoBundleLazy 'Shougo/neosnippet', {
      \ 'autoload' : {
      \   'commands' : ['NeoSnippetEdit', 'NeoSnippetSource'],
      \   'filetypes' : 'snippet',
      \   'insert' : 1,
      \   'unite_sources' : ['snippet', 'neosnippet/user', 'neosnippet/runtime'],
      \ }}

NeoBundle 'tpope/vim-rails', { 'autoload' : {
      \ 'filetypes' : ['haml', 'ruby', 'eruby'] }}

NeoBundle 'slim-template/vim-slim.git'

NeoBundleLazy 'alpaca-tc/vim-endwise.git', {
      \ 'autoload' : {
      \   'insert' : 1,
      \ }}

NeoBundleLazy 'edsono/vim-matchit', { 'autoload' : {
      \ 'filetypes': 'ruby',
      \ 'mappings' : ['nx', '%'] }}

NeoBundleLazy 'basyura/unite-rails', {
      \ 'depends' : 'Shougo/unite.vim',
      \ 'autoload' : {
      \   'unite_sources' : [
      \     'rails/bundle', 'rails/bundled_gem', 'rails/config',
      \     'rails/controller', 'rails/db', 'rails/destroy', 'rails/features',
      \     'rails/gem', 'rails/gemfile', 'rails/generate', 'rails/git', 'rails/helper',
      \     'rails/heroku', 'rails/initializer', 'rails/javascript', 'rails/lib', 'rails/log',
      \     'rails/mailer', 'rails/model', 'rails/rake', 'rails/route', 'rails/schema', 'rails/spec',
      \     'rails/stylesheet', 'rails/view'
      \   ]
      \ }}

NeoBundleLazy 'taka84u9/vim-ref-ri', {
      \ 'depends': ['Shougo/unite.vim', 'thinca/vim-ref'],
      \ 'autoload': { 'filetypes': 'g:my.ft.ruby_files' } }

NeoBundleLazy 'alpaca-tc/neorspec.vim', {
      \ 'depends' : ['alpaca-tc/vim-rails', 'tpope/vim-dispatch'],
      \ 'autoload' : {
      \   'commands' : ['RSpec', 'RSpecAll', 'RSpecCurrent', 'RSpecNearest', 'RSpecRetry']
      \ }}

NeoBundleLazy 'alpaca-tc/alpaca_tags', {
      \ 'depends': 'Shougo/vimproc',
      \ 'autoload' : {
      \   'commands': ['TagsUpdate', 'TagsSet', 'TagsBundle']
      \ }}

NeoBundleLazy 'tsukkee/unite-tag', {
      \ 'depends' : ['Shougo/unite.vim'],
      \ 'autoload' : {
      \   'unite_sources' : ['tag', 'tag/file', 'tag/include']
      \ }}

let g:neosnippet#disable_runtime_snippets = { "_": 1, }

NeoBundle "Shougo/neosnippet-snippets"
NeoBundle "Shougo/neocomplcache"
NeoBundle 'tpope/vim-haml'
NeoBundle 'skwp/vim-rspec'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" see http://qiita.com/jnchito/items/5141b3b01bced9f7f48f
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tomtom/tcomment_vim'                " 複数行コメントのON/OFF [Ctrl+-(*2) or gcc]
NeoBundle 'nathanaelkane/vim-indent-guides'    " インデントの深さを視覚化
let g:indent_guides_enable_on_vim_startup = 1  " vim起動時にvim-indent-guidesを自動でonにする
NeoBundle 'bronson/vim-trailing-whitespace'    " 行末の半角スペースの可視化

filetype plugin indent on     " required!
filetype indent on
syntax on

set autoindent
set expandtab
set hlsearch
set ignorecase
set number
set smartcase
set tabstop=2
set laststatus=2
set shiftwidth=2
" set foldmethod=indent

" カラー設定
colorscheme oceandeep
"colorscheme railscasts
"colorscheme darkblue
"colorscheme blue
"colorscheme default
"colorscheme delek
"colorscheme desert
"colorscheme elflord
"colorscheme evening
"colorscheme koehler
"colorscheme morning
"colorscheme murphy
"colorscheme pablo
"colorscheme peachpuff
"colorscheme ron
"colorscheme shine
"colorscheme slate
"colorscheme torte
"colorscheme zellner

" 以降はカラースキーム以外で指定するオリジナルのカラー設定

" タブ、全角空白可視化 -> 以下の全角スペース導入により削除
"set listchars=tab:>>,trail:_,extends:>
"set list
"highlight SpecialKey cterm=reverse ctermfg=167  guifg=bluehighlight
"highlight JpSpace    cterm=reverse ctermfg=60   guifg=red
"au BufRead,BufNew * match JpSpace /　/

" タブ、折り返しの表示
set list
set listchars=tab:>>,extends:>

" http://inari.hatenablog.com/entry/2014/05/05/231307
""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

" vim-indent-guides settings
" see http://www.absolute-keitarou.net/blog/?p=1127
let g:indent_guides_auto_colors=0
" for black background
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=232
" for ocean background
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=23
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=66
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=2

" binding.pryのハイライト
autocmd VimEnter,ColorScheme * :hi BindingPry cterm=reverse ctermfg=5 guifg=#75507b
au BufRead,BufNew * let w:m1=matchadd('BindingPry', 'binding.pry')

function! BindingPry()
    highlight BindingPry cterm=reverse ctermfg=5 guibg=#75507b
endfunction

if has('syntax')
    augroup BindingPry
        autocmd!
        autocmd ColorScheme * call BindingPry()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('BindingPry', 'binding.pry')
    augroup END
    call BindingPry()
endif

call neobundle#end()
