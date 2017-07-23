let &t_Co=256
" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" tab stuff
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

colorscheme darkdevel 

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible        " Use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start  " more powerful backspacing

" Now we set some defaults for the editor
set history=10000          " keep 50 lines of command line history
set ruler               " show the cursor position all the time

" python settings
autocmd FileType python set tabstop=4|set softtabstop=4|set shiftwidth=4|set expandtab

" functions for automagically switching to 'paste' mode when copying text into vim running in a terminal
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" line to let me set my own colorscheme in MacVim
let macvim_skip_colorscheme=1

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" mouse fix
"if has('mouse_sgr')
"  set ttymouse=sgr
"endif

" turn filetype plugin on, for (hopefully) better filetype support
filetype plugin on
