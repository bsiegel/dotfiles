" for git, add spell checking and automatic wrapping at 72 columns
  autocmd Filetype gitcommit setlocal spell textwidth=72

" go
  au BufNewFile,BufRead *.go set filetype=go

" markdown
  augroup mkd
    autocmd BufNewFile,BufRead *.mkd      set ai formatoptions=tcroqn2 comments=n:> filetype=ghmarkdownt w=72
    autocmd BufNewFile,BufRead *.md       set ai formatoptions=tcroqn2 comments=n:> filetype=ghmarkdown tw=72
    autocmd BufNewFile,BufRead *.markdown set ai formatoptions=tcroqn2 comments=n:> filetype=ghmarkdown tw=72
  augroup END

" Thorfile, Rakefile, Vagrantfile, and Gemfile are Ruby
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,*.rabl} set ft=ruby

" JSON is JS
  au BufNewFile,BufRead *.json set ai filetype=javascript