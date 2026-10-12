vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }
})

require('nvim-treesitter').install( { 'python', 'julia', 'bash', 'latex', 'markdown', 'toml' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python', 'julia', 'bash', 'sh', 'markdown', 'toml', 'yaml' },
  callback = function()
    if pcall(vim.treesitter.start) then          -- no-op if parser missing
      vim.wo[0][0].foldmethod = 'expr'
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end
  end,
})
