vim.pack.add({
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-lualine/lualine.nvim'
})


local colors = {
  black  = '#080808',
  red    = '#e06c75',
  yellow = '#e5c07b',
  cyan   = '#98c379',
  blue   = '#61afef',
  violet = '#c678dd',
  white  = '#dcdfe4',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.blue },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },

  insert = { a = { fg = colors.black, bg = colors.cyan } },
  visual = { a = { fg = colors.black, bg = colors.violet } },
  replace = { a = { fg = colors.black, bg = colors.yellow } },
  command = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}


require('lualine').setup {
options = {
    theme = bubbles_theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
sections = {
    lualine_a = { 
        { 'mode', 
        separator = { left = '' }, 
        padding = { right = 1 }, 
    } },
    lualine_b = { 'filename'},
    lualine_c = {
      '%=', --[[ add your center components here in place of this comment ]]
    },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, padding = { left = 1 } },
    },
  },

    inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {'filetype'},
    lualine_z = {'location'}
  },
}
