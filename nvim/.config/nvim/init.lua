require 'config.options'
require 'config.keymaps'
require 'config.autocommands'
require 'config.lazy'
-- Does julia-vim work without this?
vim.cmd 'runtime macros/matchit.vim'
-- vim.cmd 'highlight Normal ctermbg=none guibg=none' -- Transparent background
-- vim.keymap.set('n', 'gn', 'gn', { noremap = true, silent = true })
