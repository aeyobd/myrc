" -------------------- manditory  --------------------
set nocompatible              
filetype off                 
set encoding=utf-8




" -------------------- setings  --------------------

set number		
set relativenumber

if has("nvim-0.5.0") || has("patch-8.1.1564") 
    set signcolumn=number
endif

set noshowmode


" setup for yadi
autocmd BufRead * DetectIndent
filetype plugin indent on

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

if v:version >= 801
    Plug 'SirVer/ultisnips'

    " CMP Plugins
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-omni'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'lukas-reineke/indent-blankline.nvim'
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





" -------------------- cmp ------------------------
lua <<EOF
  -- Set up nvim-cmp.
local cmp = require'cmp'


cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body) 
        end,
    },
    confirmation = {
        get_commit_characters = function(commit_characters)
            return {}
        end
    },
    preselect = cmp.PreselectMode.None,
    mapping = cmp.mapping({
        ['C-s'] = cmp.mapping.complete({
        config = {
            sources = {
                { name = 'ultisnips' }
            }
            }
        }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-space>'] = cmp.mapping.complete(),
        ['<C-cr>'] = cmp.mapping.confirm({ select = true }),
        ['<C-e>'] = cmp.mapping.abort(),
        -- ['<C-n>'] = cmp.select_next_item(),
        -- ['<C-p>'] = cmp.select_prev_item(),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
        { name = 'path' },
        { name = 'omni' },
        { name = 'buffer' },
    })
    
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-s>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
    }),
    preselect=cmp.PreselectMode.None,
    sources = {
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-s>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
    }),
    preselect=cmp.PreselectMode.None,
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' }
    })
})

cmp.setup.filetype({'markdown', 'help' }, {
    window = {
        documentation = cmp.config.disable
    }
    })


-- require('cmp').setup.buffer {
--     formatting = {
--         format = function(entry, vim_item)
--         vim_item.menu = ({
--             omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
--             buffer = "[Buffer]",
--             -- formatting for other sources
--         })[entry.source.name]
--         return vim_item
--         end,
--     },
--     sources = {
--         { name = 'omni' },
--         { name = 'buffer' },
--     },
-- }

  -- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, 
        { name = 'buffer' },
    })
})





  -- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require'lspconfig'.jedi_language_server.setup{}
require'lspconfig'.vimls.setup{}




 -- lsp setup


require("indent_blankline").setup {
    space_char_blankline = " ",
}



EOF
