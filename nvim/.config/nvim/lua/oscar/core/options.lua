vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- show relative numbers for other lines
opt.relativenumber = true
-- show absolute number of current line
opt.number = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = false

-- search settings

opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- when mixed case, make case sensitive

opt.cursorline = true


-- opt.term
