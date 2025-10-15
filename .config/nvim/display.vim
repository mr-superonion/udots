" Color setup"
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if has('termguicolors')
  set termguicolors
endif
set background=dark

" Color Setup"
let g:gruvbox_material_background = 'hard'
" let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_disable_italic_comment = 1
colorscheme gruvbox-material
let g:airline_theme= 'gruvbox_material'
" Cursor for insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
autocmd VimEnter * silent !echo -ne "\e[2 q"

" Move in command and input mode
set backspace=2
set backspace=indent,eol,start

" display airline
set cmdheight=1
set noshowmode   " to get rid of thing like --INSERT--
set noshowcmd    " to get rid of display of last command
set shortmess+=F " to get rid of the file name displayed in the command line bar

set exrc
set hidden
set noerrorbells
set scrolloff=8

" Display Line number
set relativenumber
set nu
set history=1000
set cursorline
" Show cursorline in active window only
autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
hi CursorLine gui=underline guifg=254 guibg=254 cterm=underline ctermbg=242 ctermfg=242


" Syntax
set showmatch
set hlsearch

" line
set nowrap
set colorcolumn=80
syntax on

" Windows
" Split
set splitright
set splitbelow
" Equalize splits when Vim is resized
autocmd VimResized * wincmd =

" Rename tabs to show tab number.
  " (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)

if exists('+showtabline')

  function! MyTabLine()
    let s = ''
    let t = tabpagenr()
    let i = 1

    while i <= tabpagenr('$')
      let buflist = tabpagebuflist(i)
      let winnr = tabpagewinnr(i)

      " let s .= '%' . i . 'T'
      " let s .= '%#TabLineFill# ' " spacer

      " padding before tab contents
      let s .= (i == t ? '%#TabLineSel#▌ ' : '%#Tabline#  ')
      " let s .= ' '

      " Set the active/inactive tab colors
      let s .= (i == t ? '%#TabLineSel#' : '%#Tabline#')

      " Show the tab number as a superscript
      let s .='%{GetSuperscript('.i.')} '

      let bufnr = buflist[winnr - 1]
      let file = bufname(bufnr)
      let buftype = getbufvar(bufnr, '&buftype')

      if buftype ==? 'help'
        let file = 'help:' . fnamemodify(file, ':t:r')

      elseif buftype ==? 'quickfix'
        let file = 'quickfix'

      elseif buftype ==? 'nofile'
        if file =~? '\/.'
          let file = substitute(file, '.*\/\ze.', '', '')
        endif

      else
        " Set the filename (no path)
        let file = pathshorten(fnamemodify(file, ':t'))
      endif

      if file ==? ''
        let file = '[No Name]'
      endif

      " Set the modified flag if any buffer on the tab is modified
      for buf in tabpagebuflist(i)
        if getbufvar(buf, '&modified')
          let file = file .' ●'
          break
        endif
      endfor

      " Display the filename
      let s .= file

      " A divider after each tab (except for last)
      " if i < tabpagenr('$')
      "   let s .= ' %#TabLine#│' " |
      " else
      "   let s .= ' '
      " endif

      " padding after tab contents
      " let s .= (i == t ? '%#TabLineSel#  ' : '  ')
      let s .= '  '

      let i = i + 1

    endwhile

    let s .= '%T%#TabLineFill#%='
    " let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s

  endfunction

  set tabline=%!MyTabLine()

endif " exists("+showtabline")

" Borrowed from taboo.vim: https://github.com/gcmt/taboo.vim/blob/master/plugin/taboo.vim
function! GetSuperscript(number) abort
  let unicode_number = ''

  let small_numbers = ['⁰', '¹', '²', '³', '⁴', '⁵', '⁶', '⁷', '⁸', '⁹']
  let number_str    = string(a:number)

  for i in range(0, len(number_str) - 1)
    let unicode_number .= small_numbers[str2nr(number_str[i])]
  endfor

  return unicode_number
endfunction
