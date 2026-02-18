--------------------------------------------------------------------------------
-- 1. Install/Load Dependencies (Order Matters)
--------------------------------------------------------------------------------
vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })
vim.pack.add({ "https://github.com/kkharji/sqlite.lua" })
vim.pack.add({ "https://github.com/nvim-telescope/telescope-fzy-native.nvim" })
vim.pack.add({ "https://github.com/nvim-telescope/telescope-ui-select.nvim" })
vim.pack.add({ "https://github.com/jonarrien/telescope-cmdline.nvim" })

-- Optional: Icons (only if you have a Nerd Font)
if vim.g.have_nerd_font then
	vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })
end

-- IMPORTANT: Native package manager usually doesn't run 'make' automatically.
-- You might need to go to the plugin folder manually and run `make` for this one.
vim.pack.add({ "https://github.com/nvim-telescope/telescope-fzf-native.nvim" })

--------------------------------------------------------------------------------
-- 2. Load Main Plugins
--------------------------------------------------------------------------------
vim.pack.add({ "https://github.com/nvim-telescope/telescope.nvim" })
vim.pack.add({ "https://github.com/danielfalk/smart-open.nvim" })

--------------------------------------------------------------------------------
-- 3. Configuration
--------------------------------------------------------------------------------

-- Safely check if telescope loaded before running setup
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	print("Telescope not found")
	return
end

telescope.setup({
	pickers = {
		find_files = {
			-- use fd instead of the 'find' command, also hides hidden files by default
			find_command = { "fd", "--type", "f" },
		},
	},
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			".git",
		},
	},
	extensions = {
		-- ['ui-select'] = {
		--   require('telescope.themes').get_dropdown(),
		-- },
		-- ['file_browser'] = {},
		-- ['cmdline'] = {},
	},
})

-- Load Extensions (Wrapped in pcall in case they aren't built/installed yet)
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "ui-select")
pcall(telescope.load_extension, "file_browser")
pcall(telescope.load_extension, "cmdline")
pcall(telescope.load_extension, "smart_open")

-- Keymaps
-- See `:help telescope.builtin`
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })

-- Commandline as a floating window
-- vim.keymap.set("n", ":", "<cmd>Telescope cmdline<cr>", { desc = "Cmdline" })

-- Smart Open Shortcuts (mimic VSCode Ctrl/Cmd+P)
-- We access the extension directly now that it is loaded
local function smart_open()
	telescope.extensions.smart_open.smart_open({ cwd_only = true })
end

local smart_open_opts = { noremap = true, silent = true, desc = "Smart Open" }
vim.keymap.set("n", "<C-p>", smart_open, smart_open_opts)
vim.keymap.set("n", "<M-p>", smart_open, smart_open_opts)
-- vim.keymap.set("n", "<D-p>", smart_open, smart_open_opts)
