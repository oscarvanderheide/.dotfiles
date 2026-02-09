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
--
-- vim.pack.add({ "https://github.com/FluxxField/smart-motion.nvim" })
--
-- require("smart-motion").setup({
-- 	presets = {
-- 		words = {
-- 			w = { map = false }, -- Register but don't map w
-- 			b = { map = false }, -- Register but don't map b
-- 			e = false,
-- 			ge = false,
-- 		},
-- 		search = true, -- Disable search to free up s/S
-- 		misc = true,
-- 	},
-- })
--
-- -- Now register custom motions for s and S that use the w and b functionality
-- local smart_motion = require("smart-motion")
--
-- local motion_w = smart_motion.motions.get_by_key("w")
-- local motion_b = smart_motion.motions.get_by_key("b")
--
-- if motion_w then
-- 	smart_motion.motions.register(
-- 		"s_motion",
-- 		vim.tbl_extend("force", motion_w, {
-- 			trigger_key = "s",
-- 			map = true,
-- 			modes = { "n", "v", "o" },
-- 		})
-- 	)
-- end
--
-- if motion_b then
-- 	smart_motion.motions.register(
-- 		"S_motion",
-- 		vim.tbl_extend("force", motion_b, {
-- 			trigger_key = "S",
-- 			map = true,
-- 			modes = { "n", "v", "o" },
-- 		})
-- 	)
-- end
