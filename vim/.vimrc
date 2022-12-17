""" Vim Configuration File

" ---- 折りたたみ ----
" zo 	折畳を削除せず開く
" zO 	折畳みを全て削除せず開く
" zc 	開いている折畳を閉じる
" zC 	開いている折畳を全て閉じる
""" Basic Setting {{{1
" 編集中のファイルが変更されたら自動で読み直す
set number
set guifont=DroidSansMono\ Nerd\ Font\ 13
set guifontwide=DroidSansMono\ Nerd\ Font\ 13
"set hlsearch
set smartindent
set laststatus=2
set wildmenu
"set lines=70 columns=150
set ruler
set history=10000
set encoding=utf8
syntax enable

set autoread

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
"" set paste
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

"" disable .swp file
"set noswapfile

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

"半角文字の設定
set guifont=MS_Gothic:h9

"全角文字の設定
set guifontwide=MS_Gothic:h9

" Reload {{{2
nnoremap <Leader>r :source ~/.vimrc<CR>



""" Key Binding {{{1
" https://maku77.github.io/vim/keymap/mapleader.html
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
nnoremap <Leader>tn :tabnext<CR>
nnoremap <Leader>tp :tabprev<CR>
nnoremap <Leader>th :tabmove -1<CR>
nnoremap <Leader>tl :tabmove +1<CR>
nnoremap <silent> <leader>tf :<c-u>tatabfirst<cr>
nnoremap <silent> <leader>tl :<c-u>tablast<cr>

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

" call neobundle#begin(expand('~/.vim/bundle/'))
" NeoBundleFetch 'Shougo/neobundle.vim'
" NeoBundle 'Shougo/unite.vim'
" NeoBundle 'Shougo/neosnippet.vim'
" call neobundle#end()

filetype plugin indent on

" ---- PLUGIN SETTINGS ----
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" :PlugInstall
"call plug#begin('~/.config/nvim/plugged')
call plug#begin('~/.vim/autoload/')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

" /* NERDTree SETTINGS */
"autocmd VimEnter * NERDTree
" map + 割り当てたいキー + 割り当てたい内容
"   map　：　再帰的マップ
"   noremap ：　非再帰的マップ
nmap <C-f> :NERDTreeToggle<CR>
let g:airline#extensions#tabline#enabled = 1
nmap <C-P> <Plug>AirlineSelectPrevTab
nmap <C-N> <Plug>AirlineSelectNextTab

" /* Airline SETTINGS */
"  https://original-game.com/vim-airline/
"  https://note.com/histone/n/na8ebb8a5909f
"  Font Install
"    mkdir -p ~/.local/share/fonts
"    cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1
nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab
let g:airline_theme = 'wombat'               " テーマの指定
let g:airline#extensions#tabline#enabled = 1 " タブラインを表示
let g:airline_powerline_fonts = 1            " Powerline Fontsを利用
let g:airline#extensions#tabline#buffer_idx_mode = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

"左側に使用されるセパレータ
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
"右側に使用されるセパレータ
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.crypt = '🔒'		"暗号化されたファイル
let g:airline_symbols.linenr = '¶'			"行
let g:airline_symbols.maxlinenr = '㏑'		"最大行
let g:airline_symbols.branch = '⭠'		"gitブランチ
let g:airline_symbols.paste = 'ρ'			"ペーストモード
let g:airline_symbols.spell = 'Ꞩ'			"スペルチェック
let g:airline_symbols.notexists = '∄'		"gitで管理されていない場合
let g:airline_symbols.whitespace = 'Ξ'	"空白の警告(余分な空白など)

" Esc SETTINGS
inoremap jk <Esc>
inoremap jj <Esc>

" /* Newtr Setting */
" /// Enable Netrw (default file browser)
filetype plugin on
" /// Netrw SETTINGS
let g:netwr_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 30
let g:netrw_sizestyle = "H"
let g:netrw_timefmt = "%Y/%m/%d(%a) %H:%M:%S"
let g:netrw_preview = 1

"/// SPLIT BORDER SETTINGS
hi VertSplit cterm=none

au FileType vim setlocal foldmethod=marker
"""au FileType vim setlocal foldmethod=marker

" coc.vim
"" coc.nvim
""" <Tab>で候補をナビゲート
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
""" <Tab>で次、<S+Tab>で前
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

""" coc.vim
""" ,cd で関数の定義元へジャンプできるように設定
""" https://zenn.dev/hira/articles/940549483bf2da
nnoremap [coc] <Nop>
nmap ,c [coc]
nmap <silent>[coc]d <Plug>(coc-definition)zz


""" vim-lsp
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

"}}}

" vim: foldmethod=marker
" vim: foldcolumn=3
" vim: foldlevel=0
"
