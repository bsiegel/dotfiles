" ctrlp
" nnoremap <Leader>b :<C-U>CtrlPBuffer<CR>
" nnoremap <Leader>t :<C-U>CtrlP<CR>
" nnoremap <Leader>T :<C-U>CtrlPTag<CR>

" ag
" nmap g/ :Ag!<space>
" nmap g* :Ag! -w <C-R><C-W><space>
" nmap ga :AgAdd!<space>
" nmap gn :cnext<CR>
" nmap gp :cprev<CR>
" nmap gl :cwindow<CR>

" tagbar
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <Leader>. :TagbarToggle<CR>

" nerdtree
nmap <leader>g :NERDTreeToggle<CR>
nmap <leader>G :NERDTreeFind<CR>

" tabular
" shortcut to align text with Tabular
map <Leader>a :Tabularize<space>

" zoomwin
map <Leader>z :ZoomWin<CR>

" unimpaired
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" gundo
map <Leader>h :GundoToggle<CR>

" rspec
nmap <Leader>rc :wa<CR> :call RunCurrentSpecFile()<CR>
nmap <Leader>rn :wa<CR> :call RunNearestSpec()<CR>
nmap <Leader>rl :wa<CR> :call RunLastSpec()<CR>
nmap <Leader>ra :wa<CR> :call RunAllSpecs()<CR>

" easy wrap toggling
  nmap <Leader>w :set wrap!<cr>
  nmap <Leader>W :set nowrap<cr>

" close all other windows (in the current tab)
  nmap gW :only<cr>

" go to the alternate file (previous buffer) with g-enter
  nmap g 

" shortcuts for frequenly used files
  nmap gm :e Gemfile<cr>

" insert blank lines without going into insert mode
  nmap go o<esc>
  nmap gO O<esc>

" mapping the jumping between splits. Hold control while using vim nav.
  nmap <C-J> <C-W>j
  nmap <C-K> <C-W>k
  nmap <C-H> <C-W>h
  nmap <C-L> <C-W>l

" Yank from the cursor to the end of the line, to be consistent with C and D.
  nnoremap Y y$

" select the lines which were just pasted
  nnoremap vv `[V`]

" clean up trailing whitespace
  map <Leader>c :StripTrailingWhitespaces<cr>

" compress excess whitespace on current line
  map <Leader>e :s/\v(\S+)\s+/\1 /<cr>:nohl<cr>

" delete all buffers
  map <Leader>d :bufdo bd<cr>

" map spacebar to clear search highlight
  nnoremap <Leader><space> :noh<cr>

" buffer resizing mappings (shift + arrow key)
  nnoremap <S-Up> <c-w>+
  nnoremap <S-Down> <c-w>-
  nnoremap <S-Left> <c-w><
  nnoremap <S-Right> <c-w>>

" reindent the entire file
  map <Leader>I gg=G``<cr>

" insert the path of currently edited file into a command
" Command mode: Ctrl-P
  cmap <C-S-P> <C-R>=expand("%:p:h") . "/" <cr>


" -------------------------------

nmap <C-k> [e
nmap <C-j> ]e
vmap <C-k> [egv
vmap <C-j> ]egv
vmap <Leader>p p==:%s/\s\+$//e<CR>gq$$
nmap <silent><Leader>x :bd<CR>
nmap <silent><Leader>` :tab sball<CR>
nmap <silent><Leader>st :!subl %<CR><CR>
nmap <silent>gt :tabnext<CR>

" easyclip
nmap <silent> cp <plug>SubstituteOverMotionMap
nmap cpp <plug>SubstituteLine
xmap cp <plug>XEasyClipPaste

" expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" rooter
map <silent> <unique> <Leader>rd <Plug>RooterChangeToRootDirectory

" insertchar
nnoremap <space> :<C-U>call InsertChar#insert(v:count1)<CR>

" ag
" nmap <Leader>f :Ag<Space><C-r>=expand("<cword>")<CR>

" CtrlP
" nmap <silent><Leader><C-t> :CtrlPClearCache<CR>:<C-U>CtrlP<CR>

" fzf
nnoremap <Leader>b :<C-U>Buffers<CR>
nnoremap <Leader>t :<C-U>Files<CR>
nnoremap <Leader>T :<C-U>Tags<CR>
nmap <Leader>f :Rg<Space><C-r>=expand("<cword>")<CR>

" nerdtree
nmap <silent><Leader>] :NERDTreeToggle<CR>
nmap <silent><Leader>[ :NERDTree \| NERDTreeToggle \| NERDTreeFind<CR>
