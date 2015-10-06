call neobundle#append()
  NeoBundle "git://github.com/airblade/vim-rooter.git"
  NeoBundle "git://github.com/vim-scripts/CSApprox.git"
  NeoBundle "git://github.com/airblade/vim-gitgutter.git"
  NeoBundle "git://github.com/vim-scripts/InsertChar.git"
  NeoBundle "git://github.com/jtratner/vim-flavored-markdown.git"
  NeoBundle "git://github.com/jszakmeister/vim-togglecursor.git"
  NeoBundle "git://github.com/luochen1990/rainbow.git"
  NeoBundle "git://github.com/jamessan/vim-gnupg.git"
  NeoBundle "git://github.com/terryma/vim-expand-region.git"
  NeoBundle "git://github.com/Valloric/YouCompleteMe.git", {
        \ 'build' : {
        \     'mac' : './install.sh',
        \    },
        \ }
call neobundle#end()

color molokai

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

set runtimepath+=$GOROOT/misc/vim
au BufRead,BufNewFile *.rabl set filetype=ruby
au BufRead,BufNewFile *.go set filetype=go
au BufRead,BufNewFile *.md,*.markdown set filetype=ghmarkdown
au BufRead,BufNewFile *.md,*.markdown set tw=72

set switchbuf=usetab,newtab
set ttymouse=xterm2
set clipboard=unnamed
set timeout timeoutlen=1000 ttimeoutlen=10

" custom vim-surround surroundings
let g:surround_35 = "#{\r}"
let g:surround_36 = "\"#{\r}\""
let g:surround_37 = "{% \r %}"

let g:SuperTabDefaultCompletionType = '<C-Tab>'
let g:rainbow_active = 1
let g:rainbow_conf = {
\        'guifgs': ['#d33682', '#dc322f', '#cb4b16', '#b58900', '#719e07', '#2aa198', '#6c71c4', '#268bd2'],
\        'ctermfgs': ['red', 'green', 'yellow', 'blue', 'magenta', 'cyan', 'gray'],
\        'operators': '_,_',
\        'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/'],
\        'separately': {
\                '*': {},
\                'tex': {
\                        'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\                },
\                'vim': {
\                        'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ containedin=vimFuncBody'],
\                },
\                'xml': {
\                        'parentheses': ['start=/\v\<\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'))?)*\>/ end=#</\z1># fold'],
\                },
\                'xhtml': {
\                        'parentheses': ['start=/\v\<\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'))?)*\>/ end=#</\z1># fold'],
\                },
\                'html': {
\                        'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\                },
\                'php': {
\                        'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold', 'start=/(/ end=/)/ containedin=@htmlPreproc contains=@phpClTop', 'start=/\[/ end=/\]/ containedin=@htmlPreproc contains=@phpClTop', 'start=/{/ end=/}/ containedin=@htmlPreproc contains=@phpClTop'],
\                },
\                'css': 0,
\                'ruby': {
\                        'parentheses': [
\                                'start=/\(^\|;\)\s*class\s\+/ end=/\(^\|;\)\s*end\(\s\+\|$\|#\|;\)/',
\                                'start=/\(^\|;\)\s*module\s\+/ end=/\(^\|;\)\s*end\(\s\+\|$\|#\|;\)/',
\                                'start=/\(^\|;\)\s*def\s\+/ step=_\(^\|;\)\s*\(rescue\|ensure\|else\)\(\s\+\|$\|#\|;\)_ end=/\(^\|;\)\s*end\(\s\+\|$\|#\|;\)/',
\                                'start=/\s\+do\(\s\+\|$\|#\|;\)/ step=_\(^\|;\)\s*\(break\|next\)\(\s\+\|(\|$\|#\|;\)_ end=/\(^\|;\)\s*end\(\s\+\|$\|#\|;\)/',
\                                'start=/\(^\|;\)\s*begin\(\s\+\|$\|#\|;\)/ step=_\(^\|;\)\s*\(rescue\|ensure\|else\)\(\s\+\|$\|#\|;\)_ end=/\(^\|;\)\s*end\(\s\+\|$\|#\|;\)/',
\                                'start=/\(^\|;\)\s*for\s\+/ end=/\(^\|;\)\s*end\(\s\+\|$\|#\|;\)/',
\                                'start=/\(^\|;\)\s*while\s\+/ step=_\(^\|;\)\s*\(break\|next\)\(\s\+\|(\|$\|#\|;\)_ end=/\(^\|;\)\s*end\(\s\+\|$\|#\|;\)/',
\                                'start=/\(^\|;\)\s*until\s\+/ step=_\(^\|;\)\s*\(break\|next\)\(\s\+\|(\|$\|#\|;\)_ end=/\(^\|;\)\s*end\(\s\+\|$\|#\|;\)/',
\                                'start=/\(^\|;\)\s*case\s\+/ step=_\(^\|;\)\s*\(\(when\s\+\)\|\(else\(\s\+\|$\|#\|;\)\)\)_ end=/\(^\|;\)\s*end\(\s\+\|$\|#\|;\)/',
\                                'start=/\(^\|;\)\s*if\s\+/ step=_\(^\|;\)\s*\(\(elsif\s\+\)\|\(else\(\s\+\|$\|#\|;\)\)\)_ end=/\(^\|;\)\s*end\(\s\+\|$\|#\|;\)/',
\                                'start=/\(^\|;\)\s*unless\s\+/ step=_\(^\|;\)\s*\(\(elsif\s\+\)\|\(else\(\s\+\|$\|#\|;\)\)\)_ end=/\(^\|;\)\s*end\(\s\+\|$\|#\|;\)/',
\                                'start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/'
\                        ],
\                },
\        }
\}

cnoreabbrev hex %!xxd
cnoreabbrev hexq %!xxd -r

let g:VMPhtmlreader = 'open'
map <silent> <unique> <Leader>rd <Plug>RooterChangeToRootDirectory
nnoremap <space> :<C-U>call InsertChar#insert(v:count1)<CR>

nmap <C-k> [e
nmap <C-j> ]e
vmap <C-k> [egv
vmap <C-j> ]egv

nmap <Leader>f :Ag<Space><C-r>=expand("<cword>")<CR>
nmap <silent><Leader>x :bd<CR>
nmap <silent><Leader>` :tab sball<CR>
nmap <silent><Leader><C-t> :CtrlPClearCache<CR>:<C-U>CtrlP<CR>
nmap <silent><Leader>st :!subl %<CR><CR>
nmap <silent><Leader>] :NERDTreeToggle<CR>
nmap <silent><Leader>[ :NERDTree \| NERDTreeToggle \| NERDTreeFind<CR>
nmap <silent>gt :tabnext<CR>

set grepprg=ag\ --nogroup\ --nocolor
let g:ctrlp_use_caching = 0
unlet g:ctrlp_user_command
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'ag %s -l --nocolor -g ""']
let g:ctrlp_prompt_mappings = { 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'] }

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
