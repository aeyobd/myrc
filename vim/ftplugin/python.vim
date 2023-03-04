setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix
" if (exists('+colorcolumn'))
"   setlocal colorcolumn=80
"   highlight ColorColumn ctermbg=7
" endif

"compile and run file.
nnoremap <F2> :w! <bar> :!python3 % <return>
nnoremap <F3> :!python3 % <return>

"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap {<return> {<return>}<ESC>O 
"inoremap {;<CR> {<CR>};<ESC>O
