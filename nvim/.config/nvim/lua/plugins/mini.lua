-- Move selection (visual mode) or current line (normal mode). Defaults are Alt (Meta) + hjkl.
vim.pack.add({ "https://github.com/nvim-mini/mini.move" })

require("mini.move").setup({
	mappings = {
		-- Move visual selection in Visual mode.
		left = "<M-h>",
		right = "<M-l>",
		down = "<M-j>",
		up = "<M-k>",

		-- Move current line in Normal mode
		line_left = "<M-h>",
		line_right = "<M-l>",
		line_down = "<M-j>",
		line_up = "<M-k>",
	},
})
