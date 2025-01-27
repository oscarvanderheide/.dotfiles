return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    -- config = function()
    --   require('copilot').setup {}
    -- end,
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = '<Tab>',
          accept_word = '<Right>',
          accept_line = false,
          next = '<Down>',
          prev = '<Up>',
          dismiss = '<Left>',
        },
      },
      panel = { enabled = false },
    },
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      window = {
        layout = 'float',
      },
      panel = {
        enabled = false,
        auto_refresh = true,
      },
      suggestion = {
        enabled = false,
        -- use the built-in keymapping for "accept" (<M-l>)
        auto_trigger = true,
        accept = false, -- disable built-in keymapping
      },
      -- filetypes = {},
    },
    keys = {
      { '<leader>cc', ':CopilotChat<CR>', mode = { 'n', 'v' }, noremap = true, silent = true },
      { '<leader>ce', ':CopilotChatExplain<CR>', mode = { 'n', 'v' }, noremap = true, silent = true },
      { '<leader>cr', ':CopilotChatReset<CR>', mode = { 'n', 'v' }, noremap = true, silent = true },
    },
  },
}
