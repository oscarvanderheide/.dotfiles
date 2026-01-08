-- Interactive REPL:
--
-- The Iron plugin enables integrated REPLs with keymaps to send
-- code (lines, visual selection, etc) to the REPL.
--
-- To make it convenient, a "send smart code block" function is mapped to X
-- that makes it convenient to run script interactively by doing (roughly)
-- the following:
-- - Sends the current paragraph of code to the REPL
-- - Unless the cursor is within a function/loop/if-statement, then it sends the
--   entire function
-- - Unless these codeblocks are within a class/module, then it sends the entire class
--
-- It also quickly highlights the code that has been sent to the REPL and
vim.pack.add({
	"https://github.com/Vigemus/iron.nvim",
})

local iron = require("iron.core")
local view = require("iron.view")

-- Define the Green Gutter Highlight
vim.api.nvim_set_hl(0, "IronSentSign", { fg = "#72b08d", bold = true, default = true })

iron.setup({
	config = {
		scratch_repl = true,
		repl_filetype = function()
			return "iron"
		end,
		-- Default startup layout (Vertical Split)
		repl_open_cmd = {
			view.split.vertical.rightbelow("%45"),
			-- function()
			-- 	local width = math.floor(vim.o.columns * 0.45)
			-- 	local height = math.floor(vim.o.lines * 0.95)
			-- 	local row = vim.o.lines - 3 -- Position near bottom
			-- 	local col = math.floor((vim.o.columns - width) / 2) -- Center horizontally
			-- 	-- local col = 100
			--
			-- 	return vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, {
			-- 		relative = "editor",
			-- 		width = width,
			-- 		height = height,
			-- 		row = row,
			-- 		col = col,
			-- 		style = "minimal",
			-- 		border = "rounded", -- Optional: change to "single" or "none" if preferred
			-- 		title = " REPL ",
			-- 		title_pos = "center",
			-- 	})
			-- end,

			function()
				local width = math.floor(vim.o.columns * 0.9)
				local height = math.floor(vim.o.lines * 0.25)
				local row = vim.o.lines - height - 3 -- Position near bottom
				local col = math.floor((vim.o.columns - width) / 2) -- Center horizontally

				return vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, {
					relative = "editor",
					width = width,
					height = height,
					row = row,
					col = col,
					style = "minimal",
					border = "rounded", -- Optional: change to "single" or "none" if preferred
					title = " REPL ",
					title_pos = "center",
				})
			end,
		},

		repl_definition = {
			python = {
				format = require("iron.fts.common").bracketed_paste,
				command = { "uv", "run", "--with", "ipython", "ipython", "--no-autoindent" },
			},
			julia = { command = { "julia", "--project=." } },
			lua = { command = { "lua" } },
			bash = { command = { "bash" } },
		},
	},
	ignore_blank_lines = true,
	keymaps = {
		toggle_repl = "<space>rr",
		toggle_repl_with_cmd_1 = "<space>rv",
		toggle_repl_with_cmd_2 = "<space>rh",
		restart_repl = "<space>rR",
		visual_send = "++",
		send_line = "++",
		send_until_cursor = "<leader>ru",
	},
})

local map = vim.keymap.set

-- CONFIGURATION CONSTANTS
local HIDE_DELAY = 5000
local hide_timer = nil
local exec_namespace = vim.api.nvim_create_namespace("iron_execution")

-- 1. HELPER: FIND THE CURRENT REPL BUFFER
local function get_iron_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[buf].filetype == "iron" then
			return buf
		end
	end
	return nil
end

-- 2. HELPER: CLOSE REPL WINDOW (WITHOUT KILLING PROCESS)
local function hide_repl_window()
	local iron_buf = get_iron_buf()
	if not iron_buf then
		return
	end

	local wins = vim.api.nvim_list_wins()
	for _, win in ipairs(wins) do
		if vim.api.nvim_win_get_buf(win) == iron_buf then
			if vim.api.nvim_get_current_win() ~= win then
				vim.api.nvim_win_close(win, false)
			end
		end
	end
end

-- 3. THE SMART "X" LOGIC WITH FOLLOW MODE
local function send_smart_block()
	local bufnr = vim.api.nvim_get_current_buf()
	local node = vim.treesitter.get_node()
	local start_row, end_row

	-- A. Structural Container Detection (Treesitter)
	local root_types = {
		class_definition = true,
		function_definition = true,
		decorated_definition = true,
		for_statement = true,
		while_statement = true,
		if_statement = true,
		with_statement = true,
	}

	local target = nil
	local curr = node
	while curr do
		if root_types[curr:type()] then
			target = curr
		end
		curr = curr:parent()
	end

	if target then
		start_row, _, end_row, _ = target:range()
	else
		-- Fallback: Paragraph detection
		local cursor_row = vim.api.nvim_win_get_cursor(0)[1] - 1
		start_row = cursor_row
		while start_row > 0 do
			local line = vim.api.nvim_buf_get_lines(bufnr, start_row - 1, start_row, false)[1]
			if not line or line:match("^%s*$") then
				break
			end
			start_row = start_row - 1
		end
		end_row = cursor_row
		while end_row < vim.api.nvim_buf_line_count(bufnr) - 1 do
			local line = vim.api.nvim_buf_get_lines(bufnr, end_row + 1, end_row + 2, false)[1]
			if not line or line:match("^%s*$") then
				break
			end
			end_row = end_row + 1
		end
	end

	-- B. Ensure REPL window is visible
	local iron_buf = get_iron_buf()
	local is_visible = false
	if iron_buf then
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_get_buf(win) == iron_buf then
				is_visible = true
				break
			end
		end
	end

	if not is_visible then
		vim.cmd("IronRepl")
		vim.cmd("redraw")
	end

	-- C. Send to REPL
	local lines = vim.api.nvim_buf_get_lines(bufnr, start_row, end_row + 1, false)
	iron.send(nil, lines)

	-- D. GUTTER INDICATOR: Green Checkmark
	-- Clear old marker in this block range and set a new sign at the start_row
	vim.api.nvim_buf_clear_namespace(bufnr, exec_namespace, start_row, end_row + 1)
	vim.api.nvim_buf_set_extmark(bufnr, exec_namespace, start_row, 0, {
		sign_text = "✓",
		sign_hl_group = "IronSentSign",
		priority = 50,
	})

	-- E. Visual Flash
	local ns = vim.api.nvim_create_namespace("iron_flash")
	vim.hl.range(bufnr, ns, "IncSearch", { start_row, 0 }, { end_row, 999 }, { priority = 100 })
	vim.defer_fn(function()
		if vim.api.nvim_buf_is_valid(bufnr) then
			vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
		end
	end, 200)

	-- F. FOLLOW MODE: Timer handling
	if hide_timer then
		hide_timer:stop()
	end
	hide_timer = vim.defer_fn(function()
		hide_repl_window()
	end, HIDE_DELAY)

	-- G. Jump to Next Block
	local next_line = end_row + 1
	local total_lines = vim.api.nvim_buf_line_count(bufnr)
	while next_line < total_lines do
		local content = vim.api.nvim_buf_get_lines(bufnr, next_line, next_line + 1, false)[1]
		if content and content:match("%S") then
			break
		end
		next_line = next_line + 1
	end
	if next_line < total_lines then
		vim.api.nvim_win_set_cursor(0, { next_line + 1, 0 })
	end
end

-- Mappings
map("n", "X", send_smart_block, { desc = "󱠤 Send Smart Block to REPL" })

-- Override Restart to clear gutter signs
map("n", "<space>rR", function()
	vim.api.nvim_buf_clear_namespace(0, exec_namespace, 0, -1)
	vim.cmd("IronRestart")
end, { desc = "Restart REPL and Clear Signs" })
