-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Turn off line numbers and relative numbers for terminal buffers
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
  end,
})

-- Prevent automatically commenting lines after starting a new line in insert mode
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove { 'r', 'o', 'c' }
  end,
})

-- Open help in a vertical split instead of a horizontal split
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  callback = function()
    vim.cmd 'wincmd L' -- Move help buffer to a vertical split on the right
  end,
})

-- Folding setup for lua files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    -- My config files are nested tables so fold based on indent works fine
    vim.opt_local.foldmethod = 'indent'
    vim.opt_local.foldlevelstart = 99
    vim.opt.foldcolumn = '0'
    vim.opt.foldtext = ''
    -- Remap zM to fold all levels but then do zr once to get a nice overview of the file
    vim.api.nvim_buf_set_keymap(0, 'n', 'zM', 'zMzr', { noremap = true, silent = true })
  end,
})

-- vim.api.nvim_create_autocmd('FileType', {
-- -- Set python specific options and keymaps
--   pattern = 'python', -- Only apply to Python files
--   callback = SET_PYTHON_KEYMAPS,
-- })

-- -- Set julia specific options and keymaps
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'julia',
--   callback = SET_JULIA_KEYMAPS,
-- })

-- Open Telescope file finder when opening a directory
-- vim.api.nvim_create_autocmd('VimEnter', {
--   callback = function()
--     if vim.fn.argv(0) == '' then
--       require('telescope.builtin').find_files()
--     end
--   end,
-- })
