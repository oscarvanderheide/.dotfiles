-- Editor options

vim.g.mapleader = ' ' -- Set leader key to space
vim.g.maplocalleader = ',' -- Set local leader key to comma
vim.g.have_nerd_font = true -- Requires Nerd Font to be installed

vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.mouse = 'a' -- Enable mouse in all modes
vim.opt.wrap = false -- No line wrapping
vim.opt.expandtab = true -- Replace tab with spaces
vim.opt.showmode = false -- Don't show mode in status line
vim.opt.breakindent = true -- Indent wrapped lines
vim.opt.undofile = true -- Save undo history
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Case sensitive if pattern contains upper case
vim.opt.signcolumn = 'yes' -- Keep signcolumn on
vim.opt.updatetime = 100 -- Time before saving swap file changes
vim.opt.timeoutlen = 300 -- Time to wait for mapped key sequence
vim.opt.splitright = true -- Vertical splits open to the right
vim.opt.splitbelow = true -- Horizontal splits open below
vim.opt.inccommand = 'split' -- Preview substitutions live
vim.opt.incsearch = true -- Incremental search
vim.opt.cursorline = false -- Highlight current line
vim.opt.scrolloff = 16 -- Keep lines above and below the cursor
vim.opt.termguicolors = true -- Enable more colors
vim.opt.cmdheight = 0 -- Hide the command line
vim.opt.swapfile = false -- Disable swap files (I'll save myself)
-- vim.opt.clipboard = 'unnamedplus' -- Sync with system clipboard
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus' -- Use the system clipboard
end)
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
-- vim.opt.colorcolumn = '80,120'
