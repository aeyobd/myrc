" -------------------- manditory  --------------------
set nocompatible              
set encoding=utf-8

" setup for yadi
autocmd BufRead * DetectIndent
filetype plugin indent on


" -------------------- setings  --------------------

set number		
set relativenumber


if has("nvim-0.5.0") || has("patch-8.1.1564") 
    set signcolumn=number
endif


set noshowmode



set tabstop=4 softtabstop=4 shiftwidth=4 autoindent
set expandtab smarttab


set undofile

set mouse=a
set splitright
set splitbelow
set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99

set timeoutlen=1000
set clipboard=unnamedplus
set smartcase

" set term=kitty



" -------------------- Plugins --------------------
call plug#begin('~/.vim/autoload/')

Plug 'sonph/onehalf', {'rtp': 'vim/'}

if v:version >= 801 && has('python3')
    " CMP Plugins
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-omni'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    Plug 'SirVer/ultisnips'
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'

    Plug 'github/copilot.vim'
    " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'lukas-reineke/indent-blankline.nvim'
else
    if v:version < 801 
        echo "vim 8.0 required for advanced extensions"
    endif
    if !has('python3')
        echo "python provider not found"
    endif
endif


Plug 'rhysd/vim-grammarous', { 'on': 'GrammarousCheck' }
Plug 'timakro/vim-yadi'

" Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'dense-analysis/ale'

" language specific
Plug 'lervag/vimtex'
Plug 'JuliaEditorSupport/julia-vim', {'for': 'julia'}

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" Plug 'vim-pandoc/vim-rmarkdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}



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
let g:airline_theme='onehalfdark'
set completeopt=menu,menuone,noselect


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

let g:pandoc#folding#fdc = 0

let g:mkdp_auto_start = 0




" -------------------- Keymaps --------------------


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
nnoremap <Leader>d :call ddc#disable() <cr>


function TabToggle()
  if &expandtab
    set noexpandtab
    IndentTabs
  else
    set expandtab
    IndentSpaces
  endif
endfunction



function! PlugLoaded(name)
    return (
        \ has_key(g:plugs, a:name) &&
        \ isdirectory(g:plugs[a:name].dir) &&
        \ stridx(&runtimepath, trim(g:plugs[a:name].dir, "/")) >= 0)
endfunction





" ---------------- CMP configuration --------------
if (has("nvim-0.5.0") && PlugLoaded('nvim-cmp'))
    source ~/.vim/setup.lua
else
    
endif
