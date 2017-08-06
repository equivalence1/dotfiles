set nocompatible              " be iMproved, required
filetype off                  " required

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

call vundle#end()            " required
filetype plugin indent on    " required

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

syntax on

if $COLORTERM == 'gnome-terminal'
endif

" syntax for sql
let g:sql_type_default = 'pgsql'

colorscheme badwolf
" colorscheme darkblue
set cursorline
" hi CursorLine term=bold cterm=bold guibg=Grey40

let python_highlight_all = 1

" for powerline
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2
" for powerline

set swapfile
set dir=~/tmp

set autoread
set ruler
set ignorecase
set incsearch
set number
set hlsearch " Enable search highlighting

set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

set ttymouse=xterm2

set ai
set si

set encoding=utf8

set fileformat=unix
set ffs=unix,dos,mac

vnoremap <silent> # :call VisualSelection('b')<CR>

set laststatus=2

set pastetoggle=<F2>

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

nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>

au BufNewFile *.cpp 0r ~/.vim/template.cpp | let IndentStyle = "cpp"


command Compile !g++ -O2 -std=c++11 -Wall -Wextra -DLOCAL -Wpedantic %:t
execute pathogen#infect()
call pathogen#helptags()
