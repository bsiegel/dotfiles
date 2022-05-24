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

" ALE
let g:airline#extensions#ale#enabled = 1
let g:ale_list_window_size = 5

" Supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" CtrlP
" respect the .gitignore
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']

" tagbar
let g:tagbar_autofocus = 1

" nerdtree
let NERDTreeHijackNetrw = 0

" neomake
"autocmd! BufWritePost,BufEnter * Neomake
"let g:neomake_open_list = 2
call neomake#configure#automake('rw')

" ListToggle
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

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

let g:EasyClipEnableBlackHoleRedirect = 0
let g:EasyClipUseCutDefaults = 0

" custom vim-surround surroundings
let g:surround_35 = "#{\r}"
let g:surround_36 = "\"#{\r}\""
let g:surround_37 = "{% \r %}"

" rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
\        'guifgs': ['#d33682', '#dc322f', '#cb4b16', '#b58900', '#719e07', '#2aa198', '#6c71c4', '#268bd2'],
\        'ctermfgs': ['red', 'green', 'yellow', 'blue', 'magenta', 'cyan', 'gray'],
\}

" CtrlP
" let g:ctrlp_use_caching = 0
" unlet g:ctrlp_user_command
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'ag %s -l --nocolor -g ""']
" let g:ctrlp_prompt_mappings = { 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'] }

" deoplete
" let g:deoplete#enable_at_startup = 1

" coc
let g:airline#extensions#coc#enabled = 1
