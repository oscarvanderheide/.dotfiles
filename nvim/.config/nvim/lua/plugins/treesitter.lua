-- Treesitter
vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
	},
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	},
})

require("nvim-treesitter.configs").setup({
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-m>",
			node_incremental = "<C-m>",
			scope_incremental = false,
			node_decremental = "<C-n>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["ad"] = "@comment.outer",
				["as"] = "@statement.outer",
			},
			selection_modes = {
				["@parameter.outer"] = "v", -- charwise
				["@function.outer"] = "V", -- linewise
				["@class.outer"] = "<C-v>", -- blockwise
			},
			include_surrounding_whitespace = false,
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
				["]o"] = { "@loop.inner", "@loop.outer" },
			},
			goto_next_end = {
				["]M"] = "@function.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
				["[o"] = { "@loop.inner", "@loop.outer" },
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
			},
		},
	},
})

vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Handle nvim-treesitter updates",
	group = vim.api.nvim_create_augroup("nvim-treesitter-pack-changed-update-handler", { clear = true }),
	callback = function(event)
		if event.data.kind == "update" then
			local ok = pcall(vim.cmd, "TSUpdate")
			if ok then
				vim.notify("TSUpdate completed successfully!", vim.log.levels.INFO)
			else
				vim.notify("TSUpdate command not available yet, skipping", vim.log.levels.WARN)
			end
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	callback = function()
		local filetype = vim.bo.filetype
		if filetype and filetype ~= "" then
			local success = pcall(function()
				vim.treesitter.start()
			end)
			if not success then
				return
			end
		end
	end,
})
