local opts = {
    noremap = true,
    silent = true,
}

vim.keymap.set('n', '\\', '<Leader>')

-- fold with spacebar
vim.keymap.set('n', '<space>', 'za', opts) 

-- auto correct
vim.keymap.set('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u', opts)


-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
-- delta: 2 lines
-- vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
-- vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
-- vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
-- vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)


-- -- special functions (toggle ln, tabs, spelling, highlights)
-- -- navigations (fancy expression only maps gj when used once)
-- nnoremap <silent><expr> j ((v:count1 == 1) ? 'gj' : ':<c-u>exe "norm! " . v:count . "j"<cr>')
-- nnoremap <silent><expr> k ((v:count1 == 1) ? 'gk' : ':<c-u>exe "norm! " . v:count . "k"<cr>')
-- nnoremap <Leader>l :set relativenumber! <cr> :set number! <cr>
-- nnoremap <Leader>t :call TabToggle() <cr>
-- nnoremap <Leader>s :setlocal spell! spelllang=en_us<cr>
-- nnoremap <silent><expr> <Leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"
-- function TabToggle()
--   if &expandtab
--     set noexpandtab
--     IndentTabs
--   else
--     set expandtab
--     IndentSpaces
--   endif
-- endfunction
-- 
