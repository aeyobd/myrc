vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = "v1", name = "blink.cmp"}
})

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
