-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- -- Turn off line numbers and relative numbers for terminal buffers
-- vim.api.nvim_create_autocmd('TermOpen', {
--   pattern = '*',
--   callback = function()
--     vim.opt_local.number = false
--     vim.opt_local.relativenumber = false
--     vim.opt_local.signcolumn = 'no'
--   end,
-- })
--
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

-- -- Folding setup for lua files
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'lua',
--   callback = function()
--     -- My config files are nested tables so fold based on indent works fine
--     vim.opt_local.foldmethod = 'indent'
--     vim.opt_local.foldlevelstart = 99
--     vim.opt.foldcolumn = '0'
--     vim.opt.foldtext = ''
--     -- Remap zM to fold all levels but then do zr once to get a nice overview of the file
--     vim.api.nvim_buf_set_keymap(0, 'n', 'zM', 'zMzr', { noremap = true, silent = true })
--   end,
-- })
--
-- Dump the output of a command at the cursor position (e.g. :Dump messages or :Dump !ls)
-- (Isnt this the same as :r! ?)
vim.api.nvim_create_user_command('Dump', function(x)
  vim.cmd(string.format("put =execute('%s')", x.args))
end, {
  nargs = '+',
  desc = 'Dump the output of a command at the cursor position',
})
