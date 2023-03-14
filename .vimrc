" -------------------- manditory  --------------------
set nocompatible              
filetype off                 
set encoding=utf-8
filetype plugin on
filetype indent on



" -------------------- setings  --------------------

set signcolumn=number
set number		
set relativenumber

set tabstop=4 softtabstop=4 shiftwidth=4 autoindent
set expandtab smarttab

set undofile
set undodir=~/.vim/undo

set mouse=a
set noshowmode
set splitright
set splitbelow
set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99

set timeoutlen=1000
set clipboard=unnamedplus



" -------------------- Plugins --------------------
call plug#begin('~/.vim/autoload/')

" YCM Hook
function! BuildYCM(info)
    if a:info.status == 'installed' || a:info.force
        !./install.py
    endif
endfunction

Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'SirVer/ultisnips'
Plug 'rhysd/vim-grammarous', { 'on': 'GrammarousCheck' }
Plug 'sonph/onehalf'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'dense-analysis/ale'

Plug 'lervag/vimtex'
Plug 'JuliaEditorSupport/julia-vim', {'for': 'julia'}


call plug#end()


" -------------------- Colors! --------------------

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
syntax on
set bg=dark
colorscheme onehalfdark
let g:airline_theme='onehalfdark'


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

" AIRLINE
let g:airline#extensions#ale#enabled = 1
silent! call airline#extensions#whitespace#disable()
let g:airline_section_z  =  "%l/%L:%c"
let g:airline_section_y  =  ""

" YCM
if !exists('g:ycm_semantic_triggers')
        let g:ycm_semantic_triggers = {}
endif

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1


" -------------------- Keymaps --------------------
"
"
nnoremap \ <Leader>
"Folding with spacebar
nnoremap <space> za

"split navigations (fancy expression only maps gj when used once)
nnoremap <silent><expr> j ((v:count1 == 1) ? 'gj' : ':<c-u>exe "norm! " . v:count . "j"<cr>')
nnoremap <silent><expr> k ((v:count1 == 1) ? 'gk' : ':<c-u>exe "norm! " . v:count . "k"<cr>')


nnoremap <Leader>l :set relativenumber! <cr> :set number! <cr>
nnoremap <Leader>t :call TabToggle() <cr>

" Spelling
" setlocal spell
" set spelllang=en_us
nnoremap <Leader>s :setlocal spell! spelllang=en_us<cr>

" auto correct
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" toggle highlighting
nnoremap <silent><expr> <Leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"


" Blinking cursour
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"



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
