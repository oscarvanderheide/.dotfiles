return {

  {
    -- Toggleterm: Quickly open and manage terminals
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      -- A lot of stuff to get a floating terminal that can be toggled with <C-\>
      local Terminal = require('toggleterm.terminal').Terminal
      local floating_term = Terminal:new {
        direction = 'vertical',
        -- float_opts = {
        --   -- border = 'double',
        --   width = 120,
        --   height = 40,
        -- },
        -- function to run on opening the terminal
        on_open = function(term)
          -- Start in insert mode rather than normal mode
          vim.cmd 'startinsert!'
          -- Close terminal with q in normal mode (I actually prefer <C-\> to close)
          vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
        end,
      }

      -- Helper function to toggle the terminal
      function _floating_term_toggle()
        floating_term:toggle()
      end

      -- Use Ctrl-\ to toggle the terminal
      vim.api.nvim_set_keymap('n', '<leader>tv', '<cmd>lua _floating_term_toggle()<CR>', { noremap = true, silent = true, desc = '[T]erminal in vsplit' })

      vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>stop<CR>', { noremap = true, silent = true, desc = 'Back to [t]erminal' })
      -- vim.api.nvim_set_keymap('t', '<leader>t', '<cmd>lua _floating_term_toggle()<CR>', { noremap = true, silent = true, desc = '[T]erminal' })
      -- vim.keymap.set('n', '<leader>t', '<cmd>stop<CR>', { desc = 'Toggle Terminal' })
    end,
  },
}
