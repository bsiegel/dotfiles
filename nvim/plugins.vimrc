" airline
let g:airline_powerline_fonts = 1
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }

" Supertab
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" CtrlP
" respect the .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']

" tagbar
let g:tagbar_autofocus = 1

" nerdtree
let NERDTreeHijackNetrw = 0

" syntastic
let g:syntastic_enable_signs=1
let g:syntastic_quiet_messages = {'level': 'warning'}

" surround
" # to surround with ruby string interpolation
let g:surround_35 = "#{\r}"
" - to surround with no-output erb tag
let g:surround_45 = "<% \r %>"
" = to surround with output erb tag
let g:surround_61 = "<%= \r %>"

" rspec
let g:rspec_command = "Dispatch rspec --format=progress --no-profile {spec}"

"-----------------------------------------


" custom vim-surround surroundings
let g:surround_35 = "#{\r}"
let g:surround_36 = "\"#{\r}\""
let g:surround_37 = "{% \r %}"

" supertab
let g:SuperTabDefaultCompletionType = '<C-Tab>'

" rainbow
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

" CtrlP
let g:ctrlp_use_caching = 0
unlet g:ctrlp_user_command
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'ag %s -l --nocolor -g ""']
let g:ctrlp_prompt_mappings = { 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'] }

" YouCompleteMe
let g:ycm_rust_src_path = '/Users/brsiegel/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src'

