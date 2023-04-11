" -------------------- manditory  --------------------
set nocompatible              
filetype off                 
set encoding=utf-8
filetype plugin on
filetype indent on



" -------------------- setings  --------------------

set number		
set relativenumber
set signcolumn=number

set noshowmode

set tabstop=4 softtabstop=4 shiftwidth=4 autoindent
set expandtab smarttab

set undofile
set undodir=~/.vim/undo

set mouse=a
set splitright
set splitbelow
set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99

set timeoutlen=1000
set clipboard=unnamedplus


set term=kitty

" -------------------- Plugins --------------------
call plug#begin('~/.vim/autoload/')

" YCM Hook
function! BuildYCM(info)
    if a:info.status == 'installed' || a:info.force
        !./install.py
    endif
endfunction

if has("patch-8.1.2269")
    Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }
endif

Plug 'SirVer/ultisnips'
Plug 'rhysd/vim-grammarous', { 'on': 'GrammarousCheck' }

" Plug 'vim-airline/vim-airline-themes'
" Plug 'vim-airline/vim-airline'
Plug 'dense-analysis/ale'

Plug 'lervag/vimtex'
Plug 'JuliaEditorSupport/julia-vim', {'for': 'julia'}


call plug#end()


" -------------------- Colors! --------------------

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Blinking cursour
let &t_SI = "\<Esc>[?2004h"
let &t_EI = "\<Esc>[?2004l"
let &t_SI .= "\e[6 q"
let &t_EI .= "\e[2 q"

set termguicolors
syntax on
set bg=dark
colorscheme onehalfdark
" let g:airline_theme='onehalfdark'


" -------------------- Package options --------------------

" UltiSnips
let g:UltiSnipsExpandTrigger = '<c-s>'
let g:UltiSnipsJumpForwardTrigger = '<c-k>'
let g:UltiSnipsJumpBackwardTrigger = '<c-j>'
let g:UltiSnipsSnippetDirectories=['UltiSnips']

" ALE
let g:ale_lint_on_insert_leave = 1
let g:ale_virtualtext_cursor = 'disabled'
let g:ale_warn_about_trailing_blank_lines = 0
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_lsp_show_message_severity = 'error'
let g:ycm_min_num_of_chars_for_completion = 99

" AIRLINE
" let g:airline#extensions#ale#enabled = 1
" silent! call airline#extensions#whitespace#disable()
" let g:airline_section_z  =  "%l/%L:%c
" let g:airline_section_y  =  "

" YCM
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1


" -------------------- Statusline -----------------
"
"
hi NormalStatus ctermbg=green ctermfg=black cterm=bold
hi InsertStatus ctermbg=blue ctermfg=black cterm=bold
hi VisualStatus ctermbg=magenta ctermfg=black cterm=bold
hi ReplaceStatus ctermbg=red ctermfg=black cterm=bold
hi StatusLine ctermbg=black ctermfg=green

hi NormalStatus1 ctermbg=green ctermfg=black
hi InsertStatus1 ctermbg=blue ctermfg=black
hi VisualStatus1 ctermbg=magenta ctermfg=black
hi ReplaceStatus1 ctermbg=red ctermfg=black
hi StatusLine1 ctermbg=black ctermfg=green

hi NormalStatus2 ctermbg=black ctermfg=green 
hi InsertStatus2 ctermfg=blue ctermbg=black 
hi VisualStatus2 ctermfg=magenta ctermbg=black 
hi ReplaceStatus2 ctermfg=red ctermbg=black 
hi StatusLine2 ctermfg=black ctermbg=green

let s:statusline_modes = {
    \ 'n': 'NORMAL',
    \ 'i': 'INSERT',
    \ 'R': 'REPLACE',
    \ 'v': 'VISUAL',
    \ 'V': 'V-LINE',
    \ '\<C-v>': 'V-BLOCK',
    \ 'c': 'COMMAND',
    \ 's': 'SELECT',
    \ 'S': 'S-LINE',
    \ '\<C-s>': 'S-BLOCK',
    \ 't': 'TERM',
    \}

let s:statusline_cgroup = {
    \ 'n': 'NormalStatus',
    \ 'i': 'InsertStatus',
    \ 'R': 'ReplaceStatus',
    \ 'v': 'VisualStatus',
    \ 'V': 'VisualStatus',
    \ '\<C-v>': 'VisualStatus',
    \ 'c': 'NormalStatus',
    \ 's': 'VisualStatus',
    \ 'S': 'VisualStatus',
    \ '\<C-s>': 'VisualStatus',
    \ 't': 'NormalStatus',
    \}

function Get_current_mode_text ()
    let md = mode()
    if (has_key (s:statusline_modes, md))
        return s:statusline_modes[md]
    endif
    return md
endfunction

function Get_color(numb)
    let md = mode()
    if (has_key (s:statusline_cgroup, md))
        return "%#" . s:statusline_cgroup[md] . a:numb . "#"
    endif
    return "%#StatusLine#"
endfunction

function! TlSpell() " {{{ 
  " Returns spell state   
  return &spell ? '[spell]' : ''
endfunction    

set laststatus=2
set statusline=
set statusline+=%{%Get_color('')%}\ 
set statusline+=%{Get_current_mode_text()}\ 
set statusline+=%{%Get_color('1')%}
set statusline+=%{TlSpell()}
set statusline+=%{%Get_color('2')%}\ 
set statusline+=%f
set statusline+=%{&modified?'[+]':''}
set statusline+=%=
set statusline+=%y
set statusline+=\ 
set statusline+=%{%Get_color('1')%}\ 
set statusline+=%l
set statusline+=/
set statusline+=%L\:
set statusline+=%c
set statusline+=\ 


" -------------------- Keymaps --------------------
"
"
nnoremap \ <Leader>

" fold with space bar
nnoremap <space> za 

"navigations (fancy expression only maps gj when used once)
nnoremap <silent><expr> j ((v:count1 == 1) ? 'gj' : ':<c-u>exe "norm! " . v:count . "j"<cr>')
nnoremap <silent><expr> k ((v:count1 == 1) ? 'gk' : ':<c-u>exe "norm! " . v:count . "k"<cr>')

" auto correct
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" special functions (toggle ln, tabs, spelling, highlights)
nnoremap <Leader>l :set relativenumber! <cr> :set number! <cr>
nnoremap <Leader>t :call TabToggle() <cr>
nnoremap <Leader>s :setlocal spell! spelllang=en_us<cr>
nnoremap <silent><expr> <Leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"


function TabToggle()
  if &expandtab
    set shiftwidth=8
    set softtabstop=0
	set tabstop=8
    set noexpandtab
	set noautoindent
	set nosmarttab
  else
    set shiftwidth=4
    set softtabstop=4
	set tabstop=4
    set expandtab
	set autoindent
	set smarttab
  endif
endfunction


