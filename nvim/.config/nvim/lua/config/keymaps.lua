-- General keymaps (i.e. not specific to a certain plugin)
local set = vim.keymap.set
local functions = require 'config.functions'

-- Keymaps for quickly moving up and down within a buffer
set({ 'n', 'v' }, '<C-j>', '6j', { silent = true })
set({ 'n', 'v' }, '<C-k>', '6k', { silent = true })

-- Quit neovim
set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true, desc = 'Quit' })

-- Toggle search higlighting
set('n', '<Esc>', '<cmd>noh<CR>', { noremap = true, silent = true, desc = 'Toggle search highlighting' })

-- Change word under cursos and highlight all matches (and use <C-.> to repeat on next match)
set('n', '<C-c>', functions.change_word_under_cursor, { noremap = true, silent = true, desc = 'Change word under cursor' })

-- Repeat last change on next match
set('n', '<C-.>', 'n.', { noremap = true, silent = true, desc = 'Repeat last change on next search match' })

-- Change all occurances of word under cursor (from Primeagen?) and visual selection
set('n', 'gs', [[:%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left><Space><Bs>]], { noremap = true, silent = false, desc = 'Replace word under cursor' })
set('x', 'gs', '"zy:%s/<C-r>z/<C-r>z/g<Left><Left><Space><BS>', { noremap = true, silent = false, desc = 'Replace selected text globally' })

-- Save file like in VSCode
set('i', '<D-s>', '<Esc>:w<CR>', { noremap = true, silent = true, desc = 'Save file' })
set('n', '<D-s>', '<Esc>:w<CR>', { noremap = true, silent = true, desc = 'Save file' })

-- Select entire buffer like in VSCode
set('n', '<D-a>', 'ggVG', { noremap = true, silent = true, desc = 'Select entire file' })

-- Yank stuff around brackets (useful for lua tables)
set('n', '<C-y>', 'vabVy', { noremap = true, silent = true, desc = 'Yank entire buffer' })

-- U to redo instead of Ctrl-r
set('n', 'U', '<C-r>', { noremap = true, silent = true, desc = 'Undo' })

-- Exit terminal mode with double Esc
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Switch between editor buffers and terminal/REPL/Copilot buffers more easily
set('n', '<C-l>', functions.switch_to_next_window, { noremap = false, silent = true, desc = 'Move to REPL/Copilot' })
set('i', '<C-l>', functions.from_repl_to_next_window, { noremap = true, silent = true, desc = 'Move to next window' })
set('t', '<C-l>', '<C-\\><C-n>:lua require("config.functions").from_repl_to_next_window()<CR>', { noremap = true, silent = true, desc = 'Move back to editor' })

-- Yank/paste using system clipboard
set('n', '<leader>y', '"+y', { noremap = true, silent = true, desc = 'Yank to clipboard' })
set('n', '<leader>Y', 'gg"+yG', { noremap = true, silent = true, desc = 'Yank entire buffer to clipboard' })
set('n', '<leader>yy', '"+yy', { noremap = true, silent = true, desc = 'Yank line to clipboard' })
set('n', '<leader>p', '"+p', { noremap = true, silent = true, desc = 'Paste from clipboard' })
set('n', '<leader>P', '"+P', { noremap = true, silent = true, desc = 'Paste from clipboard' })

-- Change d to delete without yanking
set('n', 'd', '"_d', { noremap = true, silent = true, desc = 'Delete without yanking' })
set('n', '<leader>d', 'd', { noremap = true, silent = true, desc = 'Delete with yanking' })
set('n', 'D', '"_D', { noremap = true, silent = true, desc = 'Delete without yanking' })
set('x', 'd', '"_d', { noremap = true, silent = true, desc = 'Delete without yanking' })

-- Change c to change without yanking
set('n', 'c', '"_c', { noremap = true, silent = true, desc = 'Change without yanking' })
set('n', 'C', '"_C', { noremap = true, silent = true, desc = 'Change without yanking' })
set('x', 'c', '"_c', { noremap = true, silent = true, desc = 'Change without yanking' })

-- Close avante window with q or Esc in normal mode
set('n', 'q', functions.close_avante_window, { noremap = true, silent = true, desc = 'Close avante window' })

-- Use arrows to move between windows
set('n', '<left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
set('n', '<right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
set('n', '<down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
set('n', '<up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Center screen after moving half a page up or down
set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down and center' })
set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up and center' })

-- Center screen after moving to next or previous search item
set('n', 'n', 'nzzzv', { desc = 'Center after going to next search item' })
set('n', 'N', 'Nzzzv', { desc = 'Center after going to previous search item' })

-- Move selected lines up or down like in VSCode
set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move current line up' })
set('n', '<A-j>', "V:m '>+1<CR>gv=gv<Esc>", { desc = 'Select current line and move it down' })
set('n', '<A-k>', "V:m '<-2<CR>gv=gv<Esc>", { desc = 'Move current line up' })

-- Quickly alternate between two buffers
set('n', ',', '<C-^>', { noremap = true, silent = true, desc = 'Alternate two buffers' })

-- Indent selected text
set('v', '<', '<gv', { desc = 'Indent left' })
set('v', '>', '>gv', { desc = 'Indent right' })

-- Incremental rename of current word
set('n', '<leader>rn', function()
  return ':IncRename ' .. vim.fn.expand '<cword>'
end, { expr = true, desc = 'Re[N]ame Incremental' })

-- -- VSCode-like shortcut to comment/uncomment lines
-- set('n', '<D-/>', function()
--   vim.cmd 'normal gcc'
-- end, { desc = 'Comment line' })
--
-- set('v', '<D-/>', function()
--   vim.cmd 'normal gc'
-- end, { desc = 'Comment selection' })
--

-- -- Search for word under cursor or visual selection without moving to next match like * does
-- set('n', '<C-f>', functions.search_word_under_cursor, { silent = true })
-- set('x', '<C-f>', functions.search_visual_selection, { silent = true })
--
-- -- Also enable <D-d> to search for word/selection (to be able to do cmd+d on mac like in VSCode)
-- set('n', '<D-d>', functions.search_word_under_cursor, { noremap = true, silent = true, desc = 'Select word under cursor' })
-- set('x', '<D-d>', functions.search_visual_selection, { noremap = true, silent = true, desc = 'Select word under cursor' })
--
-- set('n', '<C-c>', functions.change_word_under_cursor, { noremap = true, silent = true, desc = 'Change word under cursor' })
-- set('x', '<C-c>', functions.change_visual_selection, { noremap = true, silent = true, desc = 'Change visual selection' })
--
