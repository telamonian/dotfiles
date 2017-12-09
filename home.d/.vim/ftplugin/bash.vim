" Custom bash filetype. Normally vim has a bit of trouble differentiating
" between the different shell syntaxes, especially when a file is lacking a
" standard shebang line (eg. is not an executable). Once this file is
" installed in your `.vim/ftplugin` dir, you can give vim a hint by inserting
" a line like this to the top of your file:
" 
"     # vim: filetype=bash
"
" This will be enough to ensure that vim highlights your file as bash (and not,
" for example, as sh).

" debug line
"echom "starting_bash.vim_ftplugin"

" the sh.vim syntax file check the is_bash var to figure out if sh is sh, bash, or ksh
setf sh
let b:is_bash=1
set syntax=sh

