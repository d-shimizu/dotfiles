set paste
" シンタックスハイライト有効化 (背景黒向け。白はコメントアウト
" されている設定を使用)
syntax on
highlight Normal ctermbg=black ctermfg=grey
highlight StatusLine term=none cterm=none ctermfg=black ctermbg=grey
highlight CursorLine term=none cterm=none ctermfg=none ctermbg=darkgray
"highlight Normal ctermbg=grey ctermfg=black
"highlight StatusLine term=none cterm=none ctermfg=grey ctermbg=black
"highlight CursorLine term=none cterm=none ctermfg=darkgray ctermbg=none
set nohlsearch " 検索キーワードをハイライトしないように設定
set cursorline " カーソルラインの強調表示を有効化
" 行番号を表示
set number
" ステータスラインを表示
set laststatus=2 " ステータスラインを常に表示
set statusline=%F%r%h%= " ステータスラインの内容

set bg=dark

"モードラインの有効無効
set ml


"検索結果をハイライトする
set hls

"検索をファイルの末尾まで検索したら、ファイルの先頭へループする。
set nows

"ウィンドウの幅を超える行の折り返し設定。
set nowrap

"閉じ括弧が入力されたとき、対応する括弧を表示する。
set sm

"補完候補を表示する
set wildmenu

" タブを表示するときの幅
set tabstop=4

" タブを挿入するときの幅
set shiftwidth=4
