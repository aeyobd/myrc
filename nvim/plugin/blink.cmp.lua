vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = "v1", name = "blink.cmp"}
})


-- vim.lsp.config('*', { capabilities = blink.get_lsp_capabilities() })

require("blink.cmp").setup({
    keymap = {
      preset = 'default',   -- C-space open, C-y accept, C-n/C-p select
      ['<C-k>'] = { 'snippet_forward',  'fallback' },
      ['<C-j>'] = { 'snippet_backward', 'fallback' },
    },
    sources = { 
        default = { 'lsp', 'path', 'snippets', 'buffer' } 
    },
    -- Prebuilt Rust matcher is downloaded from GitHub; fall back to the Lua
    -- implementation on servers without internet access.
    fuzzy = { implementation = 'prefer_rust' },
    completion = {
        -- The keyword should only matchh against the text before
        keyword = { range = "prefix" },
        menu = {
            -- Use treesitter to highlight the label text for the given list of sources
            draw = {
                treesitter = { "lsp" },
            },
        },
        -- Show completions after tying a trigger character, defined by the source
        trigger = { show_on_trigger_character = true },
    },
    signature = { enabled = true },
})


vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- let pyright own hover; ruff is for diagnostics/formatting
    if client and client.name == 'ruff' then
      client.server_capabilities.hoverProvider = false
    end
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf })
    vim.keymap.set('n', '<Leader>f', function() vim.lsp.buf.format({ async = true }) end,
      { buffer = args.buf })
  end,
})
