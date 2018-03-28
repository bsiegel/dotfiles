" for git, add spell checking and automatic wrapping at 72 columns
  autocmd Filetype gitcommit setlocal spell textwidth=72

" go
au BufNewFile,BufRead *.go set filetype=go

" slim
au BufNewFile,BufRead *.slim set filetype=slim

" less
au BufNewFile,BufRead *.less set filetype=less

" handlebars
au  BufNewFile,BufRead *.mustache,*.handlebars,*.hbs,*.hogan,*.hulk,*.hjs set filetype=html syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim

" stylus
au BufNewFile,BufRead *.styl set filetype=stylus

" coffee-script
au BufNewFile,BufRead *.coffee set filetype=coffee

" markdown
augroup mkd
  autocmd BufNewFile,BufRead *.mkd      set ai formatoptions=tcroqn2 comments=n:> filetype=markdown
  autocmd BufNewFile,BufRead *.md       set ai formatoptions=tcroqn2 comments=n:> filetype=markdown
  autocmd BufNewFile,BufRead *.markdown set ai formatoptions=tcroqn2 comments=n:> filetype=markdown
augroup END

" clojure
autocmd BufNewFile,BufRead *.clj set filetype=clojure
autocmd BufNewFile,BufRead *.edn set filetype=clojure
autocmd BufNewFile,BufRead *.cljs set filetype=clojure
autocmd BufNewFile,BufRead *.cljx set filetype=clojure

" jade
autocmd BufNewFile,BufRead *.jade set filetype=jade

" scala
autocmd BufNewFile,BufRead *.scala set filetype=scala

" elixir
au BufNewFile,BufRead *.ex set filetype=elixir
au BufNewFile,BufRead *.exs set filetype=elixir

" Thorfile, Rakefile, Vagrantfile, and Gemfile are Ruby
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

" JSON is JS
  au BufNewFile,BufRead *.json set ai filetype=javascript

" --------------

" Rabl is Ruby
  au BufRead,BufNewFile *.rabl set filetype=ruby

" Parse markdown with ghmarkdown
  au BufRead,BufNewFile *.md,*.markdown set filetype=ghmarkdown
  au BufRead,BufNewFile *.md,*.markdown set tw=72
