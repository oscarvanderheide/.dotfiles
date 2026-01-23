-- Move selection (visual mode) or current line (normal mode). Defaults are Alt (Meta) + hjkl.
vim.pack.add({ "https://github.com/esmuellert/codediff.nvim" })

require("codediff").setup({
	dependencies = { "MunifTanjim/nui.nvim" },
	cmd = "CodeDiff",
})
