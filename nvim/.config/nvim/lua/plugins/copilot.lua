vim.pack.add({
	{ src = "https://github.com/zbirenbaum/copilot.lua" },
})

require("copilot").setup({
	suggestion = {
		enabled = true,
		auto_trigger = true,
		keymap = {
			accept = "<Tab>",
			-- accept_word = false,
			-- accept_line = false,
			-- next = "<M-]>",
			-- prev = "<M-[>",
			-- dismiss = "<C-]>",
		},
	},
	panel = {
		enabled = true,
		auto_refresh = false,
	},
})
