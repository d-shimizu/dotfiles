""" Vim Configuration File

""" Basic Setting {{{1
"" Encoding
set encoding=utf-8
"set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,sjis,cp932,euc-jp,cp20932

"" tab indent setting
set tabstop=4
set shiftwidth=4
set softtabstop=0
"set expandtab
set smartindent

"" colum number 
set number

"" colum number highlight
set cursorline

"" paste
set paste

"" disable .swp file
set noswapfile

" StatusLine 
set laststatus=2
set statusline=%F%r%h%=

" Background Color
set bg=dark

" Modeline
set ml

" hightligth of Search Result
set hls
"set nohlsearch

set nows
set nowrap
set sm
set wildmenu

" Syntax Hightlight (背景黒向け。白はコメントアウトされている設定を使用)
syntax on
highlight Normal ctermbg=black ctermfg=grey
highlight StatusLine term=none cterm=none ctermfg=black ctermbg=grey
highlight CursorLine term=none cterm=none ctermfg=none ctermbg=darkgray
"highlight Normal ctermbg=grey ctermfg=black
"highlight StatusLine term=none cterm=none ctermfg=grey ctermbg=black
"highlight CursorLine term=none cterm=none ctermfg=darkgray ctermbg=none

" Reload {{{2
nnoremap <Leader>r :source ~/.vimrc<CR>


""" Key Binding {{{1
let mapleader = ' '
"" Split Window
nnoremap <Leader>ws :<C-w>sp<CR>
nnoremap <Leader>\| :<C-w>vs<CR>
"nnoremap <Leader>ws :<C-u>sp<CR>
"nnoremap <Leader>| :<C-u>vs<CR>

"" Move to another split window
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l

" Resize split window
nnoremap <Leader>L :10wincmd ><CR>
nnoremap <Leader>H :10wincmd <<CR>
nnoremap <Leader>K :resize +5<CR>
nnoremap <Leader>J :resize -5<CR>

" Tab
nnoremap <Leader>t :tabnew<CR>
"nnoremap <C-t> :tabnew<CR>
nnoremap <Leader>n :tabnext<CR>
nnoremap <Leader>p :tabprev<CR>
nnoremap <Leader>th :tabmove -1<CR>
nnoremap <Leader>tl :tabmove +1<CR>

" Macker
noremap <Leader>fc :<C-u>:foldclose<CR>

" GNU GLOBAL
nmap <C-g> :Gtags -g
nmap <C-G> :Gtags -f %<CR>
nmap <C-j> :GtagsCursor<CR>
nmap <C-j> :Gtags <C-r><C-w><CR>
nmap <C-k> :Gtags -r <C-r><C-w><CR>
nmap <C-n> :cn<CR>
nmap <C-p> :cp<CR>

"" sudo redirection
"command W w !sudo tee % > /dev/null
cmap w!! w !sudo tee % > /dev/null

""" Plugins {{{1
set nocompatible
filetype plugin indent off

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neosnippet.vim'
call neobundle#end()

filetype plugin indent on
"}}}

" vim: foldmethod=marker
" vim: foldcolumn=3
" vim: foldlevel=0
