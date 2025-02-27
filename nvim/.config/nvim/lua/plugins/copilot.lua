return {
  {
    -- Copilot: Non-official but better version of github/copilot.vim
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
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
    -- Copilot Chat
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    disabled = true,
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      window = {
        layout = 'vertical',
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
    },
    -- keys = {
    --   { '<leader>cc', ':CopilotChat<CR>', mode = { 'n', 'v' }, noremap = true, silent = true },
    --   { '<leader>ce', ':CopilotChatExplain<CR>', mode = { 'n', 'v' }, noremap = true, silent = true },
    --   { '<leader>cr', ':CopilotChatReset<CR>', mode = { 'n', 'v' }, noremap = true, silent = true },
    -- },
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('codecompanion').setup {
        adapters = {
          -- Modify the copilot adapter to use the claude-3.7-sonnet model
          claude_sonnet = function()
            return require('codecompanion.adapters').extend('copilot', {
              name = 'claude_sonnet', -- Give this adapter a different name to differentiate it from the default ollama adapter
              schema = {
                model = {
                  default = 'claude-3.7-sonnet',
                },
                num_ctx = {
                  default = 16384,
                },
                num_predict = {
                  default = -1,
                },
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = 'claude_sonnet',
          },
          inline = {
            adapter = 'claude_sonnet',
          },
        },
      }
    end,

    keys = {
      { '<leader>cc', ':CodeCompanionChat Toggle<CR>', mode = { 'n', 'v' }, noremap = true, silent = true },
      { '<leader>ce', ':CodeCompanion /explain<CR>', mode = { 'n', 'v' }, noremap = true, silent = true },
      { '<leader>cf', ':CodeCompanion /fix<CR>', mode = { 'n', 'v' }, noremap = true, silent = true },
      -- { '<leader>cr', ':CopilotChatReset<CR>', mode = { 'n', 'v' }, noremap = true, silent = true },
    },
  },
  -- {
  --   'yetone/avante.nvim',
  --   event = 'VeryLazy',
  --   lazy = false,
  --   version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  --   opts = {
  --     -- add any opts here
  --     -- for example
  --     provider = 'copilot',
  --     copilot = {},
  --     windows = {
  --       ask = { floating = true },
  --     },
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = 'make',
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     'stevearc/dressing.nvim',
  --     'nvim-lua/plenary.nvim',
  --     'MunifTanjim/nui.nvim',
  --     --- The below dependencies are optional,
  --     'echasnovski/mini.pick', -- for file_selector provider mini.pick
  --     'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
  --     'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
  --     'ibhagwan/fzf-lua', -- for file_selector provider fzf
  --     'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
  --     'zbirenbaum/copilot.lua', -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       'HakonHarnes/img-clip.nvim',
  --       event = 'VeryLazy',
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { 'markdown', 'Avante' },
  --       },
  --       ft = { 'markdown', 'Avante' },
  --     },
  --   },
  -- },
}
