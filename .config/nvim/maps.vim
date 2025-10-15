" Unused keys
nmap x <Nop>
nmap X <Nop>
nmap <A-h> <Nop>
nmap <A-l> <Nop>
nmap <C-b> <Nop>
nmap <C-f> <Nop>
nmap (( <Nop>
inoremap <C-N> <Nop>
inoremap <C-P> <Nop>
nnoremap <SPACE> <Nop>

" leader
let g:mapleader=" "
let maplocalleader = " "

" Navigation:
nnoremap J 10<c-e>
nnoremap K 10<c-y>
nnoremap { {zz
nnoremap } }zz

" Basics
nnoremap Y y$
nnoremap yy Y
nnoremap V v$
nnoremap vv V

" Tab Control
nmap <ESC>h <Nop>
nmap <ESC>l <Nop>

" Window Control
nnoremap <C-w>" :wincmd =<CR>
nnoremap <C-w>= :new<CR>
nnoremap <C-w>% :vnew<CR>
nnoremap <C-w>x :q!<CR>

" Tabs
nnoremap <C-t> :tabnew<CR>
nnoremap L :tabnext<CR>
nnoremap H :tabprevious<CR>

" Copy and paste
" " Vim's auto indentation feature does not work properly with text copied
" from outside of Vim. Press the <F2> key to toggle paste mode on/off.
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set clipboard=unnamedplus

" This is for copy paster between servers
" Visual mode yank selected area to tmux paste buffer (clipboard)
vnoremap <Leader>y "zy:silent! call SendZBufferToHomeDotClipboard()<cr>
" Put from tmux clipboard
nnoremap <Leader>p :silent! call HomeDotClipboardPut()<cr>
function! SendZBufferToHomeDotClipboard()
    " Yank the contents buffer z to file ~/.clipboard and tmux paste buffer
    " For use with HomeDotClipboardPut()
    silent! redir! > ~/.clipboard
    silent! echon @z
    silent! redir END
endfunction
function! HomeDotClipboardPut()
    " Paste/Put the contents of file ~/.clipboard
    " For use with SendZBufferToHomeDotClipboard()
    exe 'let @z=""'
    silent! let @z = system("cat ~/.clipboard")
    " put the z buffer on the line below
    silent! norm "zp
endfunction

" auto close ([{'"
inoremap (( ()<Esc>i
inoremap [[ []<Esc>i
inoremap {{ {}<Esc>i
inoremap '' ''<Esc>i
inoremap "" ""<Esc>i

" Spell Autocheck
set spelllang=en
nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>
highlight SpellBad ctermfg=009 ctermbg=000 cterm=underline

" Substitute " Replace all is aliased to S.
nnoremap S :%s///g<Left><Left>
vnoremap // "zy/\V<C-R>=escape(@z,'/\')<CR><CR>

" vim-commentary
function UnmapCommentary()
  unmap gc
  nunmap gcc
endfunction
autocmd VimEnter * call UnmapCommentary()
xmap <leader>c  <Plug>Commentary
omap <leader>c  <Plug>Commentary
nmap <leader>cc <Plug>CommentaryLine

