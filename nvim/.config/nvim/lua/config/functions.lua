-- A file with my own functions used in e.g. keymaps, autocommands and plugins
-- to keep the other files clean and focused on their main purpose.
local M = {}

--## Search word under cursor or selection

-- Search for word under cursor
-- Same as *N but doesn't move screen position if next match if far away
-- Note that it also moves the cursor to the start of the word to help with .-repeating
-- because n or N also move to start of word
function M.search_word_under_cursor()
  -- Get the word under cursor
  local word = vim.fn.expand '<cword>'
  -- Get the current column position
  local current_col = vim.fn.col '.'
  -- Get the start column of the word
  local word_start_col = vim.fn.matchstrpos(vim.fn.getline '.', '\\<' .. word .. '\\>')[2] + 1

  -- If the cursor is not at the start of the word, move it to the start
  if current_col ~= word_start_col then
    vim.fn.cursor(vim.fn.line '.', word_start_col)
  end
  vim.fn.setreg('/', '\\<' .. word .. '\\>') -- Set search pattern without moving
  vim.opt.hlsearch = true -- Ensure search highlighting is enabled

  vim.cmd 'redraw!' -- Ensure highlighting updates
end

-- Search for visual selection (e.g. * from vim-asterik followed by N)
-- Same as (* from vim-asterik)N but doesn't move screen position if next match if far away
function M.search_visual_selection()
  -- Save the start and end positions of the visual selection
  local start_pos = vim.fn.getpos "'<"

  -- Get the selected text
  vim.cmd 'normal! "vy' -- Copy selection to register v
  local selected_text = vim.fn.getreg 'v' -- Get the copied text
  selected_text = vim.fn.escape(selected_text, '\\/.*$^~[]') -- Escape special chars

  -- Set the search register and enable highlighting
  vim.fn.setreg('/', '\\V' .. selected_text) -- \V makes it literal
  vim.opt.hlsearch = true
  vim.cmd 'redraw!'

  -- Exit visual mode
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)

  -- Move cursor to the start of the selection
  -- vim.api.nvim_win_set_cursor(0, { start_pos[2], start_pos[3] - 1 })
end

function M.cmd_d()
  local mode = vim.fn.mode()
  local search_pat = vim.fn.getreg '/'

  if search_pat == '' then
    -- no active search
    if mode:match '[vV]' then
      M.search_visual_selection()
    else
      M.search_word_under_cursor()
    end
    -- visually select the match
    vim.cmd 'normal! vgn'
  else
    -- search already active → jump to next match
    vim.cmd 'normal! n'
    -- reselect it
    vim.cmd 'normal! vgn'
  end
end

-- Change the word under cursor and make it 'n.'-repeatable
function M.change_word_under_cursor()
  local word = vim.fn.expand '<cword>'
  local new_word = vim.fn.input('Replace "' .. word .. '" with: ')
  -- Search for the exact word under cursor
  M.search_word_under_cursor() -- Highlight the word under cursor

  if new_word ~= '' then
    -- Replace the first match and allow repetition with '.'
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('cgn' .. new_word .. '<Esc>', true, false, true), 'n', true)
  end
end

function M.change_visual_selection()
  -- -- Get the selected text
  -- vim.cmd 'normal! "vy' -- Copy selection to register v
  -- local selected_text = vim.fn.getreg 'v' -- Get the copied text
  -- selected_text = vim.fn.escape(selected_text, '\\/.*$^~[]') -- Escape special chars

  -- Prompt the user to input a new text
  local new_text = vim.fn.input 'Replace selection with: '
  M.search_visual_selection() -- Highlight the visual selection
  if new_text ~= '' then
    -- Replace the first match and allow repetition with '.'
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('cgn' .. new_text .. '<Esc>', true, false, true), 'n', true)
  end
end

--## Switch more easily between normal buffers and Terminal/REPL/Copilot buffers
-- Automatically enters and exits insert mode when switching to and from such buffers
function M.switch_to_next_window()
  vim.cmd 'wincmd w'
  local filetype = vim.bo.filetype

  if filetype == 'Avante' then
    -- Avante has a bunch of buffers stacked vertically, the Ask buffer is the bottom
    -- one.
    vim.cmd 'wincmd w'
    vim.cmd 'wincmd w'
    vim.cmd 'startinsert!'
  elseif filetype == 'iron' or filetype == 'copilot-chat' or filetype == 'toggleterm' or filetype == 'AvanteInput' then
    vim.cmd 'startinsert!'
  elseif filetype == 'notify' then
    -- recurse
    M.switch_to_next_window()
  end
end

-- Exit insert mode when moving from REPL/Copilot to normal buffer
function M.from_repl_to_next_window()
  vim.cmd 'stopinsert'
  vim.cmd 'wincmd w'

  local filetype = vim.bo.filetype
  if filetype == 'notify' then
    -- recurse
    M.from_repl_to_next_window()
  end
end

-- Close Avante more easily
function M.close_avante_window()
  if vim.bo.filetype == 'Avante' then
    vim.cmd 'q'
  end
end

return M
