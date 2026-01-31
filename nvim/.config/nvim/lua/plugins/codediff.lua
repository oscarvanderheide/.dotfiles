-- Move selection (visual mode) or current line (normal mode). Defaults are Alt (Meta) + hjkl.
vim.pack.add({ "https://github.com/esmuellert/codediff.nvim" })

require("codediff").setup({
	dependencies = { "MunifTanjim/nui.nvim" },
	cmd = "CodeDiff",
	-- By default, the inserts are blueish. I like these colors betters.
	-- Also, by default, the characters have slightly different colors than the lines
	-- I prefer them to be the same.
	highlights = {
		line_insert = "#384534",
		char_insert = "#384534",
		line_delete = "#4C3136",
		char_delete = "#4C3136",
		char_brightness = 1.6,
	},
})
