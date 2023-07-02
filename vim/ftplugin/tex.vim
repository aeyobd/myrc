" Needed for reverse search
if empty(v:servername) && exists('*remote_startserver')
      call remote_startserver('VIM')
endif

au User VimtexEventInitPost call vimtex#compiler#compile()

" for autosave to autocopile`
autocmd CursorHold * update
set updatetime=3000

"Automatic wrapping
set wrap linebreak 
set whichwrap+=<,>,h,l
set textwidth=0

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

