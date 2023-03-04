set nocompatible              " required
filetype off                  " required

set encoding=utf-8
set number			" line numbers
set relativenumber

"enable filetype plugins
filetype plugin on
filetype indent on

"------------- settings --------------
set foldmethod=indent
set foldlevel=99


set signcolumn=number

set undofile
set undodir=~/.vim/undo

" reduces time that airline changes color. Destroys use of leader key 
set timeoutlen=1000

"enable mouse
set mouse=v

set tabstop=4 softtabstop=4 shiftwidth=4 autoindent
set expandtab smarttab
set noshowmode
set noshowcmd
set splitright
set splitbelow
set backspace=indent,eol,start


" Spelling
setlocal spell
set spelllang=en_us

call plug#begin('~/.vim/autoload/')

Plug 'SirVer/ultisnips'
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'dense-analysis/ale'
Plug 'rhysd/vim-grammarous', { 'on': 'GrammarousCheck' }

"Plug 'vim-scripts/AutoClose'
"Plug 'noahfrederick/vim-noctu'
"Plug 'jeffkreeftmeijer/vim-dim'
Plug 'vim-airline/vim-airline-themes'
" Plug 'dracula/vim'
" Plug 'altercation/vim-colors-solarized'
" Plug 'lifepillar/vim-solarized8'

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }
call plug#end()


" colorsheme
packadd! onedark.vim
syntax on
set bg=dark
colorscheme onedark

" package options
let g:UltiSnipsExpandTrigger = '<c-s>'
let g:UltiSnipsJumpForwardTrigger = '<c-k>'
let g:UltiSnipsJumpBackwardTrigger = '<c-j>'
let g:UltiSnipsSnippetDirectories=['UltiSnips']


let g:airline#extensions#ale#enabled = 1
let g:ale_lint_on_insert_leave = 1
silent! call airline#extensions#whitespace#disable()


if !exists('g:ycm_semantic_triggers')
        let g:ycm_semantic_triggers = {}
endif
au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme

"Folding with spacebar
nnoremap <space> za

"split navigations (fancy expression only maps gj when used once)
nnoremap <silent><expr> j ((v:count1 == 1) ? 'gj' : ':<c-u>exe "norm! " . v:count . "j"<cr>')
nnoremap <silent><expr> k ((v:count1 == 1) ? 'gk' : ':<c-u>exe "norm! " . v:count . "k"<cr>')
vnoremap <silent><expr> j ((v:count1 == 1) ? 'gj' : ':<c-u>exe "norm! " . v:count . "j"<cr>')
vnoremap <silent><expr> k ((v:count1 == 1) ? 'gk' : ':<c-u>exe "norm! " . v:count . "k"<cr>')



nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap \ <Leader>
nnoremap <Leader>s :setlocal spell! spelllang=en_us<cr>
nnoremap <Leader>l :set relativenumber! <cr> :set number! <cr>
nnoremap <Leader>t :call TabToggle() <cr>


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


inoremap <S-Tab> <C-V><Tab>

" autocorrect
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

nnoremap <silent><expr> <Leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" Wayland clipboard support
set clipboard=unnamedplus
xnoremap "+y y:call system("wl-copy", @"")<cr>
nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p"


" curser
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
"

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"


