if empty(v:servername) && exists('*remote_startserver')
      call remote_startserver('VIM')
endif

au User VimtexEventInitPost call vimtex#compiler#compile()

au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme

" for autosave to autocopile`
autocmd CursorHold,CursorHoldI * update
set updatetime=3000

"Automatic wrapping
set textwidth=79 

"Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura_simple'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
let g:ale_linters_explicit = 1
let g:quickfix_is_open = 0
let maplocalleader = "\\"



set foldmethod=expr
set foldexpr=vimtex#fold#level(v:lnum)
set foldtext=vimtex#fold#text()

nnoremap <leader>q :call QuickfixToggle()<cr>
nnoremap <leader>c :call ConcealToggle()<cr>


" function! ZathuraHook() abort
"   if exists('b:vimtex.viewer.xwin_id') && b:vimtex.viewer.xwin_id <= 0
"     silent call system('xdotool windowactivate ' . b:vimtex.viewer.xwin_id . ' --sync')
"     silent call system('xdotool windowraise ' . b:vimtex.viewer.xwin_id)
"   endif
" endfunction
" 
" augroup vimrc_vimtex
"   autocmd!
"   autocmd User VimtexEventView call ZathuraHook()
" augroup END

function! QuickfixToggle()
    if g:quickfix_is_open
    cclose
    let g:quickfix_is_open = 0
    execute g:quickfix_return_to_window . "wincmd w"
    else
    let g:quickfix_return_to_window = winnr()
    copen
    let g:quickfix_is_open = 1
    endif
endfunction

function! ConcealToggle()
    if &conceallevel
    set conceallevel=0
    else
    set conceallevel=2
    endif
endfunction

inoremap ' '
inoremap " "

