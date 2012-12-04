Bundle "git://github.com/airblade/vim-rooter.git"
Bundle "git://github.com/vim-scripts/CSApprox.git"
Bundle "git://github.com/derekwyatt/vim-scala.git"
color molokai

au BufRead,BufNewFile *.scala set filetype=scala

let g:ackprg = 'ag --nogroup --nocolor --column'

cnoreabbrev hex %!xxd
cnoreabbrev hexq %!xxd -r

let g:VMPhtmlreader = 'open'
map <silent> <unique> <Leader>rd <Plug>RooterChangeToRootDirectory

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
    normal yl
    let l:charlen = byteidx(getreg(), 1)
    call cursor(0, curcol + l:charlen)
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
    normal yl
    let l:charlen = byteidx(getreg(), 1)
    call cursor(0, col(".") + l:charlen)
  endif
  if a:mode == "v"
    normal msgv`s
  endif
  return ""
endfunction
