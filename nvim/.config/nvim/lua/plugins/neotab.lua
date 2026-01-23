-- Neotab: press tab in insert mode to move out of brackets, quotes, etc.
-- Without this plugin, auto-pair plugins kinda suck
vim.pack.add({ "https://github.com/kawre/neotab.nvim" })

require("neotab").setup()
