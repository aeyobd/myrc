-- Plug 'SirVer/ultisnips'
-- " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
-- Plug 'lukas-reineke/indent-blankline.nvim'
-- 
-- 
-- Plug 'rhysd/vim-grammarous', { 'on': 'GrammarousCheck' }
-- Plug 'timakro/vim-yadi'
-- 
-- " Plug 'vim-airline/vim-airline-themes'
-- Plug 'vim-airline/vim-airline'
-- 
-- " language specific
-- Plug 'lervag/vimtex'
-- Plug 'JuliaEditorSupport/julia-vim', {'for': 'julia'}
-- 
-- Plug 'vim-pandoc/vim-pandoc'
-- Plug 'vim-pandoc/vim-pandoc-syntax'
-- " Plug 'vim-pandoc/vim-rmarkdown'
-- Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}



-- Only reached on nvim >= 0.11 (guarded in vimrc), but double-check anyway
if vim.fn.has('nvim-0.11') == 0 then return end

------------------------------------------------------------------
-- Diagnostics
------------------------------------------------------------------
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = { border = 'rounded' },
})

------------------------------------------------------------------
-- Completion (blink.cmp)
------------------------------------------------------------------

------------------------------------------------------------------
-- LSP (built-in API, 0.11+)
------------------------------------------------------------------
if ok_blink then
  vim.lsp.config('*', { capabilities = blink.get_lsp_capabilities() })
end

vim.lsp.config('pyright', {
  settings = { python = { analysis = { typeCheckingMode = 'basic' } } },
})

-- Enable a server only if its executable exists on this machine
local servers = {
  ruff    = 'ruff',
  pyright = 'pyright-langserver',
  julials = 'julia',
}
for name, exe in pairs(servers) do
  if vim.fn.executable(exe) == 1 then
    vim.lsp.enable(name)
  end
end

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
-- Defaults you get for free in 0.11+: K hover, grn rename, gra code action,
-- grr references, gri implementation, gO symbols, [d / ]d diagnostics, <C-s> signature help (insert)

------------------------------------------------------------------
-- Treesitter (main-branch API)
------------------------------------------------------------------
local ok_ts, ts = pcall(require, 'nvim-treesitter')
if ok_ts then
  -- Installing parsers needs the tree-sitter CLI and a C compiler.
  -- Only try if both exist; already-installed parsers work regardless.
  if vim.fn.executable('tree-sitter') == 1 and vim.fn.executable('cc') == 1 then
    ts.install({ 'python', 'julia', 'bash', 'latex', 'markdown', 'markdown_inline', 'toml', 'yaml' })
  end
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'python', 'julia', 'bash', 'sh', 'markdown', 'toml', 'yaml' },
    callback = function()
      if pcall(vim.treesitter.start) then          -- no-op if parser missing
        vim.wo[0][0].foldmethod = 'expr'
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      end
    end,
  })
end

------------------------------------------------------------------
-- indent-blankline v3
------------------------------------------------------------------
local ok_ibl, ibl = pcall(require, 'ibl')
if ok_ibl then ibl.setup() end




