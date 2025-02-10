-- General keymaps (i.e. not specific to a certain plugin)

local set = vim.keymap.set

-- Quit neovim
set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true, desc = 'Quit' })

-- Toggle search higlighting
set('n', '<Esc>', '<cmd>noh<CR>', { noremap = true, silent = true, desc = 'Toggle search highlighting' })

-- Select word under cursor or visual selection
set('n', '<D-d>', '*N', { noremap = true, silent = true, desc = 'Select word under cursor' })
set('x', '<D-d>', '<Plug>(visualstar-*)N', { noremap = true, silent = true, desc = 'Select word under cursor' })
set('n', '<C-f>', '*N', { noremap = true, silent = true, desc = 'Select word under cursor' })
set('x', '<C-f>', '<Plug>(visualstar-*)N', { noremap = true, silent = true, desc = 'Select word under cursor' })
-- Change word under cursor or visual selection
set('n', '<C-c>', '*Ncgn', { noremap = true, silent = true, desc = 'Change inner word (n/N/.-repeatable)' })
set('x', '<C-c>', '<Plug>(visualstar-*)Ncgn', { noremap = true, silent = true, desc = 'Change inner word (n/N/.-repeatable)' })
-- Repeat last change on next search match
set('n', '<C-.>', 'n.', { noremap = true, silent = true, desc = 'Repeat last change on next search match' })
-- set('n', '<C-l>', '*Ngcn', { noremap = true, silent = true, desc = 'Search for word under cursor' })

-- Change all occurances of word under cursor (from Primeagen?) and visual selection
set('n', 'gs', [[:%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left><Space><Bs>]], { noremap = true, silent = false, desc = 'Replace word under cursor' })
set('x', 'gs', '"zy:%s/<C-r>z/<C-r>z/g<Left><Left><Space><BS>', { noremap = true, silent = false, desc = 'Replace selected text globally' })

-- Remap J and K to move paragraphs
set({ 'n', 'o', 'v' }, 'J', '}', { noremap = true, silent = true, desc = 'Move to next paragraph' })
set({ 'n', 'o', 'v' }, 'K', '{', { noremap = true, silent = true, desc = 'Move to previous paragraph' })

-- Keymaps for quickly moving up and down within a buffer
set({ 'n', 'v' }, '<C-j>', function()
  vim.cmd 'normal! 6j'
end, { silent = true })
set({ 'n', 'v' }, '<C-k>', function()
  vim.cmd 'normal! 6k'
end, { silent = true })

-- Save file like in VSCode
set('i', '<D-s>', '<Esc>:w<CR>', { noremap = true, silent = true, desc = 'Save file' })
set('n', '<D-s>', '<Esc>:w<CR>', { noremap = true, silent = true, desc = 'Save file' })

-- Select entire buffer like in VSCode
set('n', '<D-a>', 'ggVG', { noremap = true, silent = true, desc = 'Select entire file' })

-- Diagnostic quickfix list
-- set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- U to redo
set('n', 'U', '<C-r>', { noremap = true, silent = true, desc = 'Undo' })

-- Exit terminal mode with double Esc
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Function to close the avante window
local function close_avante_window()
  if vim.bo.filetype == 'avante' then
    vim.cmd 'q'
  end
end

-- Use <C-h> to move to REPL/Copilot window and directly start typing, or move to editor
local function switch_to_next_window()
  -- Switch to the next window and, for REPL or Copilot windows, enter insert mode
  vim.cmd 'wincmd w'
  local filetype = vim.bo.filetype

  if filetype == 'Avante' then
    -- Avante has a bunch of buffers stacked vertically, the Ask buffer is the bottom
    -- one. But doing avante focus twice will bring the focus to that ask buffer.
    vim.cmd 'normal! <leader>af'
    vim.cmd 'normal! <leader>af'
  elseif filetype == 'iron' or filetype == 'copilot-chat' or filetype == 'toggleterm' then
    vim.cmd 'startinsert!'
  end
end

local function from_repl_to_next_window()
  vim.cmd 'stopinsert'
  vim.cmd 'wincmd w'
end

set('n', '<C-h>', switch_to_next_window, { noremap = false, silent = true, desc = 'Move to REPL/Copilot' })
set('i', '<C-h>', from_repl_to_next_window, { noremap = true, silent = true, desc = 'Move to next window' })
set('t', '<C-h>', '<C-\\><C-n><C-w>w', { noremap = true, silent = true, desc = 'Move back to editor' })

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

-- Close avante window with q or Esc in normal mode
set('n', 'q', close_avante_window, { noremap = true, silent = true, desc = 'Close avante window' })

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

-- VSCode-like shortcut to comment/uncomment lines
set('n', '<D-/>', function()
  vim.cmd 'normal gcc'
end, { desc = 'Comment line' })

set('v', '<D-/>', function()
  vim.cmd 'normal gc'
end, { desc = 'Comment selection' })

-- Incremental rename of current word
vim.keymap.set('n', '<leader>rn', function()
  return ':IncRename ' .. vim.fn.expand '<cword>'
end, { expr = true, desc = 'Re[N]ame Incremental' })
