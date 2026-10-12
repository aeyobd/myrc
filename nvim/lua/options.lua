-- filetype plugin indent on
-- set smartcase

-- visual
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'number'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.showmode = false
vim.opt.guicursor = 'a:blinkon100'

-- tabs
vim.opt.tabstop = 8 
vim.opt.softtabstop = 4 
vim.opt.shiftwidth = 4 
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true

-- functionality
vim.opt.mouse = 'a'
vim.opt.undofile = true 
vim.opt.timeoutlen = 1000


vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = { border = 'rounded' },
})

