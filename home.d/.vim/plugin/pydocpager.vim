" inspired by https://github.com/vim/vim/issues/2323

command! -nargs=0 PYDOCPAGER call s:PydocPager() | delcommand PYDOCPAGER

function! s:PydocPager()
  set nocompatible
  if exists('+viminfofile')
    set viminfofile=NONE
  endif
  set noswapfile 

  setlocal ft=man
  runtime ftplugin/man.vim
  setlocal buftype=nofile bufhidden=hide iskeyword+=: modifiable

  " Emulate 'col -b'
  silent keepj keepp %s/\v(.)\b\ze\1?//ge

  " Remove empty lines above the header
  "call cursor(1, 1)
  "let n = search(".*(.*)", "c")
  "if n > 1
  "  exe "1," . n-1 . "d"
  "endif
  setlocal nomodified readonly

  syntax on
endfunction
