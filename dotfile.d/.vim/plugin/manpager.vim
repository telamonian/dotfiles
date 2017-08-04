" Vim plugin for using Vim as manpager.
" Maintainer: Enno Nagel <ennonagel+vim@gmail.com>
" Last Change: 2016 May 20

" $MAN_PN is supposed to be set by MANPAGER, see ":help manpager.vim".
if empty($MAN_PN)
  finish
endif

command! -nargs=0 MANPAGER call s:MANPAGER() | delcommand MANPAGER

function! s:MANPAGER()
  let page_pattern = '\v\w+%([-_.]\w+)*'
  let sec_pattern = '\v\w+%(\+\w+)*'
  let pagesec_pattern = '\v(' . page_pattern . ')\((' . sec_pattern . ')\)'

  if $MAN_PN is '1'
    let manpage = ""
    let i = 1

    " Search for manpage header line in the first 10 lines of input
    while (manpage =~ '^\s*$') && (i <= 10)
      let manpage = matchstr( getline(i), '^' . pagesec_pattern )
      let i += 1
    endwhile

    " if no manpage header was found, raise an error
    if manpage =~ '^\s*$'
      echoerr "Script in" . expand('%:p')  . " was unable to find a recognizable\n" . "manpage header in first " . i  . " lines of input."
    endif
  else
    let manpage = expand('$MAN_PN')
  endif

  let page_sec = matchlist(tolower(manpage), '^' . pagesec_pattern  . '$')

  bwipe!

  setlocal filetype=man
  exe 'Man' page_sec[2] page_sec[1]
endfunction
