-- General keymaps (i.e. not specific to a certain plugin)

local set = vim.keymap.set
local functions = require("config.functions")
local opts = { noremap = true, silent = true }

-- Keymaps for quickly moving up and down within a buffer
-- I tried stuff in the past based on treesitter to quickly move to next functions/classes/etc
-- but it was always too language specific. Somehow this approach works well for me.
set({ "n", "v" }, "<C-j>", "6j", { silent = true })
set({ "n", "v" }, "<C-k>", "6k", { silent = true })

-- Quit/restart neovim
set("n", "<leader>qq", ":q<CR>", { noremap = true, silent = true, desc = "Quit" })
set("n", "<leader>qr", ":restart<CR>", { noremap = true, silent = true, desc = "Restart" })

-- -- Search for word under cursor or visual selection without moving to next match like * does
set("n", "<C-v>", functions.search_word_under_cursor, { silent = true })
set("x", "<C-v>", functions.search_visual_selection, { silent = true })

-- Get rid of search highlighting with esc
set("n", "<Esc>", "<cmd>noh<CR>", { noremap = true, silent = true, desc = "Toggle search highlighting" })

-- Change word under cursor and highlight all matches (and use <C-.> to repeat on next match)
-- set('n', '<C-f>', functions.search_word_under_cursor, { noremap = true, silent = true, desc = 'Change word under cursor' })
-- set('n', '<D-f>', functions.search_word_under_cursor, { noremap = true, silent = true, desc = 'Change word under cursor' })
-- set('n', '<C-c>', 'ciw', { noremap = true, silent = true, desc = 'Change word under cursor' })

-- Change word under cursor (and add it to search first to make it easy to repeat the change
-- with the <C-.> mapping defined below)
local function search_and_change_word()
	functions.search_word_under_cursor()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("ciw", true, false, true), "n", true)
end

set("n", "<C-c>", search_and_change_word, { noremap = true, silent = true, desc = "Change word under cursor" })

-- Repeat last change on next match, nice to combine with previous <C-c> keymap
set("n", "<C-.>", "n.", { noremap = true, silent = true, desc = "Repeat last change on next search match" })

-- -- Change all occurances of word under cursor (from Primeagen?) and visual selection
-- set(
-- 	"n",
-- 	"<C-f>",
-- 	[[:%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left><Space><Bs>]],
-- 	{ noremap = true, silent = false, desc = "Replace word under cursor" }
-- )
-- set(
-- 	"x",
-- 	"<C-f>",
-- 	'"zy:%s/<C-r>z/<C-r>z/g<Left><Left><Space><BS>',
-- 	{ noremap = true, silent = false, desc = "Replace selected text globally" }
-- )
--
-- Save file like in VSCode
set("i", "<C-s>", "<Esc>:w<CR>", { noremap = true, silent = true, desc = "Save file" })
set("n", "<C-s>", "<Esc>:w<CR>", { noremap = true, silent = true, desc = "Save file" })
set("i", "<D-s>", "<Esc>:w<CR>", { noremap = true, silent = true, desc = "Save file" })
set("n", "<D-s>", "<Esc>:w<CR>", { noremap = true, silent = true, desc = "Save file" })

-- Search with Cmd+f - using Snacks picker (configured in snacks.lua)
-- vim.keymap.set("n", "<D-f>", "/", { noremap = true, silent = false, desc = "Search" })
-- vim.keymap.set("n", "<C-f>", "/", { noremap = true, silent = false, desc = "Search" })
-- vim.keymap.set('n', '<leader>f', '/')
-- vim.keymap.set("n", "<M-f>", "/", { noremap = true, silent = false, desc = "Search" })

-- Select entire buffer like in VSCode
set("n", "<C-a>", "ggVG", { noremap = true, silent = true, desc = "Select entire file" })
set("n", "<D-a>", "ggVG", { noremap = true, silent = true, desc = "Select entire file" })

-- Bridge the signals from Ghostty to <D-...>
-- We use 'remap = true' so they trigger your actual bindings
vim.keymap.set({ "n", "i", "v" }, "<M-a>", "<D-a>", { remap = true })
vim.keymap.set({ "n", "i", "v" }, "<M-p>", "<D-p>", { remap = true })
vim.keymap.set({ "n", "i", "v" }, "<M-f>", "<D-f>", { remap = true })
vim.keymap.set({ "n", "i", "v" }, "<M-s>", "<D-s>", { remap = true })
-- Yank stuff around brackets (useful for lua tables)

set("n", "<C-y>", "vabVy", { noremap = true, silent = true, desc = "Yank entire buffer" })

-- U to redo instead of Ctrl-r
set("n", "U", "<C-r>", { noremap = true, silent = true, desc = "Undo" })

-- Exit terminal mode with double Esc
set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Toggle inlay hints (LSP type annotations)
set("n", "<leader>th", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }))
end, { desc = "Toggle Inlay Hints" })

-- Switch between editor buffers and terminal/REPL/Copilot buffers more easily
set("n", "<C-l>", functions.switch_to_next_window, { noremap = false, silent = true, desc = "Move to REPL/Copilot" })
set("i", "<C-l>", functions.from_repl_to_next_window, { noremap = true, silent = true, desc = "Move to next window" })
set(
	"t",
	"<C-l>",
	'<C-\\><C-n>:lua require("config.functions").from_repl_to_next_window()<CR>',
	{ noremap = true, silent = true, desc = "Move back to editor" }
)

-- Yank/paste using system clipboard
set("n", "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
set("n", "<leader>Y", 'gg"+yG', { noremap = true, silent = true, desc = "Yank entire buffer to clipboard" })
set("n", "<leader>yy", '"+yy', { noremap = true, silent = true, desc = "Yank line to clipboard" })
set("n", "<leader>p", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
set("n", "<leader>P", '"+P', { noremap = true, silent = true, desc = "Paste from clipboard" })

-- Change d to delete without yanking
set("n", "d", '"_d', { noremap = true, silent = true, desc = "Delete without yanking" })
set("n", "<leader>d", "d", { noremap = true, silent = true, desc = "Delete with yanking" })
set("n", "D", '"_D', { noremap = true, silent = true, desc = "Delete without yanking" })
set("x", "d", '"_d', { noremap = true, silent = true, desc = "Delete without yanking" })

-- Change c to change without yanking
set("n", "c", '"_c', { noremap = true, silent = true, desc = "Change without yanking" })
set("n", "C", '"_C', { noremap = true, silent = true, desc = "Change without yanking" })
set("x", "c", '"_c', { noremap = true, silent = true, desc = "Change without yanking" })

-- Close avante window with q or Esc in normal mode
set("n", "q", functions.close_avante_window, { noremap = true, silent = true, desc = "Close avante window" })

-- Use arrows to move between windows
set("n", "<left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
set("n", "<right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
set("n", "<down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
set("n", "<up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Center screen after moving half a page up or down
set("n", "<C-d>", "<C-d>zz", { desc = "Half page down and center" })
set("n", "<C-u>", "<C-u>zz", { desc = "Half page up and center" })

-- Center screen after moving to next or previous search item
set("n", "n", "nzzzv", { desc = "Center after going to next search item" })
set("n", "N", "Nzzzv", { desc = "Center after going to previous search item" })

-- Move selected lines up or down like in VSCode: using some plugin instead I think
-- set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
-- set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move current line up' })
-- set('n', '<A-j>', "V:m '>+1<CR>gv=gv<Esc>", { desc = 'Select current line and move it down' })
-- set('n', '<A-k>', "V:m '<-2<CR>gv=gv<Esc>", { desc = 'Move current line up' })

-- Quickly alternate between two buffers
set("n", ",", "<C-^>", { noremap = true, silent = true, desc = "Alternate two buffers" })

-- Indent selected text (can also use Alt+{h,l} from mini.move instead)
set("v", "<", "<gv", { desc = "Indent left" })
set("v", ">", ">gv", { desc = "Indent right" })

-- -- Incremental rename of current word
-- set('n', '<leader>rn', function()
--   return ':IncRename ' .. vim.fn.expand '<cword>'
-- end, { expr = true, desc = 'Re[N]ame Incremental' })

-- -- VSCode-like shortcut to comment/uncomment lines
-- set('n', '<D-/>', function()
--   vim.cmd 'normal gcc'
-- end, { desc = 'Comment line' })
--
-- set('v', '<D-/>', function()
--   vim.cmd 'normal gc'
-- end, { desc = 'Comment selection' })
--

-- Map brackets in visual mode to surround selected text
set("x", "(", "<Esc>`>a)<Esc>`<i(<Esc>", { silent = true })
set("x", ")", "<Esc>`>a)<Esc>`<i(<Esc>", { silent = true })
set("x", "[", "<Esc>`>a]<Esc>`<i[<Esc>", { silent = true })
set("x", "]", "<Esc>`>a]<Esc>`<i[<Esc>", { silent = true })
set("x", "{", "<Esc>`>a}<Esc>`<i{<Esc>", { silent = true })
set("x", "}", "<Esc>`>a}<Esc>`<i{<Esc>", { silent = true })
set("x", "'", "<Esc>`>a'<Esc>`<i'<Esc>", { silent = true })
set("x", '"', '<Esc>`>a"<Esc>`<i"<Esc>', { silent = true })
set("x", "`", "<Esc>`>a`<Esc>`<i`<Esc>", { silent = true })

--
-- -- Also enable <D-d> to search for word/selection (to be able to do cmd+d on mac like in VSCode)
-- set('n', '<D-d>', functions.search_word_under_cursor, { noremap = true, silent = true, desc = 'Select word under cursor' })
-- set('x', '<D-d>', functions.search_visual_selection, { noremap = true, silent = true, desc = 'Select word under cursor' })
--
-- set('n', '<C-c>', functions.change_word_under_cursor, { noremap = true, silent = true, desc = 'Change word under cursor' })
-- set('x', '<C-c>', functions.change_visual_selection, { noremap = true, silent = true, desc = 'Change visual selection' })
--

-- Better indenting (stay in visual mode)
set("v", "<", "<gv")
set("v", ">", ">gv")

-- Better paste (doesn't replace clipboard with deleted text)
set("v", "p", '"_dP', opts)

-- Smart undo break-points (create undo points at logical stops)
set("i", ",", ",<c-g>u")
set("i", ".", ".<c-g>u")
set("i", ";", ";<c-g>u")

-- -- Auto-close pairs (simple, no plugin needed)
-- set("i", "`", "``<left>")
-- set("i", '"', '""<left>')
-- set("i", "(", "()<left>")
-- set("i", "[", "[]<left>")
-- set("i", "{", "{}<left>")
-- set("i", "<", "<><left>")
-- Note: Single quotes commented out to avoid conflicts in some contexts
-- set("i", "'", "''<left>")

-- ═══════════════════════════════════════════════════════════
-- FOLDING NAVIGATION (for code organization)
-- ═══════════════════════════════════════════════════════════

-- Close all folds except current one (great for focus)
set("n", "zv", "zMzvzz", { desc = "Close all folds except the current one" })

-- Smart fold navigation (closes current, opens next/previous)
set("n", "zj", "zcjzOzz", { desc = "Close current fold when open. Always open next fold." })
set("n", "zk", "zckzOzz", { desc = "Close current fold when open. Always open previous fold." })

-- Toggle line wrapping
set("n", "<leader>tw", "<cmd>set wrap!<CR>", { desc = "Toggle Wrap", silent = true })

-- Toggle folding
set("n", "<leader>to", "<cmd>set foldenable!<CR>", { desc = "Toggle Folding", silent = true })

-- Show LSP code actions
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Actions" })
