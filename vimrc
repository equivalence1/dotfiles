" Settings {{{

" Switch syntax highlighting on, when the terminal has colors
syntax on
" Use vim, not vi api
set nocompatible
" Just move them to tmp
set swapfile
set dir=/tmp
" Autoload files that have changed outside of vim
set autoread
" Always show cursor
set ruler
" Ignore case in search
set smartcase
" Make sure any searches /searchPhrase doesn't need the \c escape character
set ignorecase
" Search as you type
set incsearch
" Show line numbers
set number
" Highlight search results
set hlsearch
" Allow backspace to delete end of line, indent and start of line characters
set backspace=indent,eol,start
" Convert tabs to spaces
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
" Highlight tailing whitespace
" See issue: https://github.com/Integralist/ProVim/issues/4
set list listchars=tab:\ \ ,trail:·
" Always show statusline
set laststatus=2
" UTF encoding
set encoding=utf8

set ttymouse=xterm2
" Highlight the current line
set cursorline
" highlight a matching [{()}] when cursor is placed on start/end character
" set showmatch

set ai
set si

" tmux: don't erase background color
set t_ut=

" Use system clipboard
" http://stackoverflow.com/questions/8134647/copy-and-paste-in-vim-via-keyboard-between-different-mac-terminals
set clipboard+=unnamed

set fileformat=unix
set ffs=unix,dos,mac

set pastetoggle=<F2>

" syntax for sql
let g:sql_type_default = 'pgsql'

" Agda
let g:agda_extraincpaths = ["/usr/share/agda-stdlib"]

colorscheme badwolf

let python_highlight_all = 1

" }}}


" Plugins {{{

filetype off                 " required by Pathogen
filetype plugin indent on    " required by Pathogen

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rust-lang/rust.vim'
Plugin 'dag/vim2hs'
Plugin 'derekwyatt/vim-scala'
Plugin 'derekelkins/agda-vim'
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'terryma/vim-multiple-cursors'

call vundle#end()

" YCM settings {{{
let g:ycm_register_as_syntastic_checker = 1 "default 1
let g:Show_diagnostics_ui = 1 "default 1
let g:ycm_always_populate_location_list = 1 "default 0

let g:clang_library_path = "/usr/lib64/"
let g:clang_complete_copen = 0
let g:clang_hl_errors = 1
let g:clang_snippets = 1
let g:clang_snippets_engine = "ultisnips"
let g:clang_close_preview = 1
let g:clang_complete_macros = 1

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
" }}}

" for powerline
" set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/

execute pathogen#infect()
call pathogen#helptags()

" }}}


" Mappings {{{

" for powerline
vnoremap <silent> # :call VisualSelection('b')<CR>

map <F5> :edit!<cr>
map <c-s> :w<cr>
map <c-z> :undo<cr>
nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
nmap \t :set expandtab tabstop=4 softtabstop=4 shiftwidth=4<CR>

" open tagbar
nmap <F8> :TagbarToggle<CR>
" open nerdtree
nmap <F7> :NERDTreeToggle<CR>
" open it automatically
" autocmd vimenter * NERDTree


" Agda
let maplocalleader = ","

command! -nargs=0 Load call Load(0)
command! -nargs=0 AgdaVersion call AgdaVersion(0)
command! -nargs=0 Reload silent! make!|redraw!
command! -nargs=0 RestartAgda exec s:python_cmd 'RestartAgda()'
command! -nargs=0 ShowImplicitArguments exec s:python_cmd "sendCommand('ShowImplicitArgs True')"
command! -nargs=0 HideImplicitArguments exec s:python_cmd "sendCommand('ShowImplicitArgs False')"
command! -nargs=0 ToggleImplicitArguments exec s:python_cmd "sendCommand('ToggleImplicitArgs')"
command! -nargs=0 Constraints exec s:python_cmd "sendCommand('Cmd_constraints')"
command! -nargs=0 Metas exec s:python_cmd "sendCommand('Cmd_metas')"
command! -nargs=0 SolveAll exec s:python_cmd "sendCommand('Cmd_solveAll')"
command! -nargs=1 ShowModule call ShowModule(<args>)
command! -nargs=1 WhyInScope call WhyInScope(<args>)
command! -nargs=1 SetRewriteMode exec s:python_cmd "setRewriteMode('<args>')"

nnoremap <buffer> <LocalLeader>l :Reload<CR>
nnoremap <buffer> <LocalLeader>t :call Infer()<CR>
nnoremap <buffer> <LocalLeader>r :call Refine("False")<CR>
nnoremap <buffer> <LocalLeader>R :call Refine("True")<CR>
nnoremap <buffer> <LocalLeader>g :call Give()<CR>
nnoremap <buffer> <LocalLeader>c :call MakeCase()<CR>
nnoremap <buffer> <LocalLeader>a :call Auto()<CR>
nnoremap <buffer> <LocalLeader>e :call Context()<CR>
nnoremap <buffer> <LocalLeader>n :call Normalize("False")<CR>
nnoremap <buffer> <LocalLeader>N :call Normalize("True")<CR>
nnoremap <buffer> <LocalLeader>M :call ShowModule('')<CR>
nnoremap <buffer> <LocalLeader>y :call WhyInScope('')<CR>
nnoremap <buffer> <LocalLeader>m :Metas<CR>

let maplocalleader = "\\"

" Show/reload metas
nnoremap <buffer> <C-e> :Metas<CR>
inoremap <buffer> <C-e> <C-o>:Metas<CR>

" Go to next/previous meta
nnoremap <buffer> <silent> <C-g>  :let _s=@/<CR>/ {!\\| ?<CR>:let @/=_s<CR>2l
inoremap <buffer> <silent> <C-g>  <C-o>:let _s=@/<CR><C-o>/ {!\\| ?<CR><C-o>:let @/=_s<CR><C-o>2l

nnoremap <buffer> <silent> <C-y>  2h:let _s=@/<CR>? {!\\| \?<CR>:let @/=_s<CR>2l
inoremap <buffer> <silent> <C-y>  <C-o>2h<C-o>:let _s=@/<CR><C-o>? {!\\| \?<CR><C-o>:let @/=_s<CR><C-o>2l

" }}}


" Commands {{{

" Rainbow parenthesis always on!
if exists(':RainbowParenthesesToggle')
  autocmd VimEnter * RainbowParenthesesToggle
  autocmd Syntax * RainbowParenthesesLoadRound
  autocmd Syntax * RainbowParenthesesLoadSquare
  autocmd Syntax * RainbowParenthesesLoadBraces
endif

" Change colour scheme when diffing
fun! SetDiffColors()
  highlight DiffAdd    cterm=bold ctermfg=white ctermbg=DarkGreen
  highlight DiffDelete cterm=bold ctermfg=white ctermbg=DarkGrey
  highlight DiffChange cterm=bold ctermfg=white ctermbg=DarkBlue
  highlight DiffText   cterm=bold ctermfg=white ctermbg=DarkRed
endfun
autocmd FilterWritePre * call SetDiffColors()

" Close all folds when opening a new buffer
autocmd BufRead * setlocal foldmethod=marker
autocmd BufRead * normal zM

" }}}

" ACM {{{

" au BufNewFile *.cpp 0r ~/.vim/template.cpp | let IndentStyle = "cpp"
" command Compile !g++ -O2 -std=c++11 -Wall -Wextra -DLOCAL -Wpedantic %:t

" }}}
