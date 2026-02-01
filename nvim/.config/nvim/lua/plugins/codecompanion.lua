vim.pack.add({
	{ src = "https://www.github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{
		src = "https://www.github.com/olimorris/codecompanion.nvim",
		version = vim.version.range("^18.0.0"),
	},
})

require("codecompanion").setup({

	-- Use opencode agent
	-- Requires opencode to be installed and configured separately (i.e. outside of neovim)
	interactions = {
		chat = {
			adapter = "opencode",
			model = "gpt-4.1",
		},
		inline = {
			adapter = "copilot",
		},
		cmd = {
			adapter = "copilot",
		},
		background = {
			adapter = "copilot",
		},
	},

	-- Set to floating window
	display = {
		chat = {
			window = {
				layout = "float", -- float|vertical|horizontal|buffer
			},
		},
	},
})

vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
