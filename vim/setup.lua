local cmp = require'cmp'



-- main setupt options
cmp.setup({

    snippet = { -- snippet engine
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body) 
        end,
    },

    window = { -- completion = cmp.config.window.bordered()
    },

    mapping = cmp.mapping({
        ['<c-s>'] = cmp.mapping.complete({
            config = {
                sources = {
                    { name = 'ultisnips' }
                }
                }
        }),
        ['<c-b>'] = cmp.mapping.scroll_docs(-4),
        ['<c-f>'] = cmp.mapping.scroll_docs(4),
        ['<c-space>'] = cmp.mapping.complete(),
        -- ['<c-cr>'] = cmp.mapping.confirm({ select = true }),
        ['<c-e>'] = cmp.mapping.abort(),
        ['<c-n>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                cmp.complete()
                -- fallback()
            end
        end,
        ['<c-p>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
    }),

    confirmation = {
        get_commit_characters = function(commit_characters)
            return {}
        end
    },

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
        { name = 'path' },
        { name = 'omni' },
    }),

    preselect = cmp.PreselectMode.None,

    view = {
        entries = "custom",
    },

    completion = {
        autocomplete = false
    }
    
})



-- set options for vim search
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


-- set options for vim commandline
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


-- markdown 
cmp.setup.filetype({'markdown', 'help' }, {
    window = {
        documentation = cmp.config.disable
    }
    })


  -- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, 
        { name = 'buffer' },
    })
})





  -- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- rewuires jedi-language-server
-- pip install jedi-language-server
require'lspconfig'.jedi_language_server.setup{}
require'lspconfig'.vimls.setup{}


