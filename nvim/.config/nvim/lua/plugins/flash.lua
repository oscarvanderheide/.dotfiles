-- flash.nvim (motion) plugin configuration
-- Also used for incremental selection instead of treesitter's removed feature
vim.pack.add({
	"https://github.com/folke/flash.nvim",
})

local flash = require("flash")
flash.setup()

-- Search for stuff in visible part of window
vim.keymap.set({ "n", "x", "o" }, "s", function()
	flash.jump()
end, { desc = "Flash" })
-- Visually select based on treesitter - don't ever use this, might as well use incremental search no?
vim.keymap.set({ "n", "x", "o" }, "S", function()
	flash.treesitter()
end, { desc = "Flash" })
-- Don't remember anymore what the below stuff is for
-- vim.keymap.set("o", "r", function()
-- 	flash.remote()
-- end, { desc = "Treesitter search" })
-- vim.keymap.set({ "x", "o" }, "S", function()
-- 	flash.treesitter_search()
-- end, { desc = "Flash" })
-- vim.keymap.set("c", "<c-s>", function()
-- 	flash.toggle()
-- end, { desc = "Toggle Flash search" })
