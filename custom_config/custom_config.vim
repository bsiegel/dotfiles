Bundle "git://github.com/airblade/vim-rooter.git"
Bundle "git://github.com/vim-scripts/CSApprox.git"
Bundle "git://github.com/derekwyatt/vim-scala.git"
Bundle "git://github.com/airblade/vim-gitgutter.git"
Bundle "git://github.com/vim-scripts/InsertChar.git"
color molokai

au BufRead,BufNewFile *.rabl set filetype=ruby
au BufRead,BufNewFile *.scala set filetype=scala

set switchbuf=usetab,newtab
set ttymouse=xterm2
let g:ackprg = 'ag --nogroup --nocolor --column'

cnoreabbrev hex %!xxd
cnoreabbrev hexq %!xxd -r

let g:VMPhtmlreader = 'open'
map <silent> <unique> <Leader>rd <Plug>RooterChangeToRootDirectory
nnoremap <space> :<C-U>call InsertChar#insert(v:count1)<CR>

nmap <C-k> [e
nmap <C-j> ]e
vmap <C-k> [egv
vmap <C-j> ]egv

nmap <Leader>f :Ack<Space><C-r>=expand("<cword>")<CR>
nmap <silent><Leader>x :bd<CR>
nmap <silent><Leader>` :tab sball<CR>
nmap <silent><Leader><C-t> :CtrlPClearCache<CR>:<C-U>CtrlP<CR>
nmap <silent><Leader>st :!subl %<CR><CR>
nmap <silent><Leader>] :NERDTreeToggle<CR>
nmap <silent><Leader>[ :NERDTree \| NERDTreeToggle \| NERDTreeFind<CR>

"This allows for change paste motion cp{motion}
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
  silent exe "normal! `[v`]\"_c"
  silent exe "normal! p"
endfunction

nmap <silent><Home> :call SmartHome("n")<CR>
nmap <silent><End> :call SmartEnd("n")<CR>
imap <silent><Home> <C-r>=SmartHome("i")<CR>
imap <silent><End> <C-r>=SmartEnd("i")<CR>
vmap <silent><Home> <Esc>:call SmartHome("v")<CR>
vmap <silent><End> <Esc>:call SmartEnd("v")<CR>

function SmartHome(mode)
  let curcol = col(".")
  "gravitate towards beginning for wrapped lines
  if curcol > indent(".") + 2
    call cursor(0, curcol - 1)
  endif
  if curcol == 1 || curcol > indent(".") + 1
    if &wrap
      normal g^
    else
      normal ^
    endif
  else
    if &wrap
      normal g0
    else
      normal 0
    endif
  endif
  if a:mode == "v"
    normal msgv`s
  endif
  return ""
endfunction

function SmartEnd(mode)
  let curcol = col(".")
  let lastcol = a:mode == "i" ? col("$") : col("$") - 1
  "gravitate towards ending for wrapped lines
  if curcol < lastcol - 1
    call cursor(0, curcol + 1)
  endif
  if curcol < lastcol
    if &wrap
      normal g$
    else
      normal $
    endif
  else
    normal g_
  endif
  "correct edit mode cursor position, put after current character
  if a:mode == "i"
    call cursor(0, col(".") + 1)
  endif
  if a:mode == "v"
    normal msgv`s
  endif
  return ""
endfunction
