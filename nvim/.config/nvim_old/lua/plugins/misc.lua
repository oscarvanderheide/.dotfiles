return {
  -- {
  --   -- Mini.ai: Extra textobjects to select inside quotes, brackets, etc.
  --   'echasnovski/mini.ai',
  --   event = 'VeryLazy', -- Load only when needed
  --   dependencies = { 'GCBallesteros/NotebookNavigator.nvim' },
  --   opts = function()
  --     -- Enable v{i,a}h to select code cells
  --     local nn = require 'notebook-navigator'
  --     local opts = { custom_textobjects = { h = nn.miniai_spec } }
  --
  --     return opts
  --   end,
  -- },
  --
  -- Mini.move: Move lines and visual selection with Alt + hjkl
  {
    'echasnovski/mini.move',
    version = '*',
    config = function()
      require('mini.move').setup {
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
          left = '<M-h>',
          right = '<M-l>',
          down = '<M-j>',
          up = '<M-k>',

          -- Move current line in Normal mode
          line_left = '<M-h>',
          line_right = '<M-l>',
          line_down = '<M-j>',
          line_up = '<M-k>',
        },
      }
    end,
  },
  -- {
  --   -- Mini.surround: Surround text with brackets, quotes, etc.
  --   'echasnovski/mini.surround',
  --   version = false,
  --   opts = {},
  --   config = function(_, opts)
  --     require('mini.surround').setup(opts)
  --
  --     -- Map brackets in visual mode to surround selected text
  --     vim.keymap.set('x', '(', '<Esc>`>a)<Esc>`<i(<Esc>', { silent = true })
  --     -- vim.keymap.set('x', '(', ":<C-u>lua MiniSurround.add('visual', '(')<CR>", { silent = true })
  --     -- vim.keymap.set('x', '[', ":<C-u>lua MiniSurround.add('visual', '[')<CR>", { silent = true })
  --     -- vim.keymap.set('x', '{', ":<C-u>lua MiniSurround.add('visual', '{')<CR>", { silent = true })
  --     -- vim.keymap.set('x', "'", ":<C-u>lua MiniSurround.add('visual', \"'\")<CR>", { silent = true })
  --     -- vim.keymap.set('x', '"', ":<C-u>lua MiniSurround.add('visual', '\"')<CR>", { silent = true })
  --     -- vim.keymap.set('x', '`', ":<C-u>lua MiniSurround.add('visual', '`')<CR>", { silent = true })
  --   end,
  -- },
  --
  {
    -- Auto-session: Remember the state of your neovim session
    'rmagatti/auto-session',
    lazy = false,
    opts = {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      -- log_level = 'debug',
    },
  },
  --
  -- {
  --   -- Lastplace: Jump to where you left off when opening a file
  --   'ethanholz/nvim-lastplace',
  --   opts = {
  --     lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
  --     lastplace_ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
  --     lastplace_open_folds = true,
  --   },
  -- },
  --
  -- {
  --   -- TreeSJ: Split/join blocks of code.
  --   'Wansmer/treesj',
  --   dependencies = 'nvim-treesitter',
  --   keys = { { '<leader>j', '<cmd>TSJToggle<cr>', desc = '[J]oin/split code block' } },
  --   opts = { use_default_keymaps = false },
  -- },
  --
  -- {
  --   -- Tree-pairs: Jump using % to the other end of a treesitter node
  --   'yorickpeterse/nvim-tree-pairs',
  --   event = 'VeryLazy',
  --   opts = {},
  -- },
  --
  -- {
  --   -- Automatically set tabstops and indents
  --   'tpope/vim-sleuth',
  -- },
  --
  -- {
  --   -- Multi-cursor with <C-n> or <C-{Up,Down}>, loving it
  --   'mg979/vim-visual-multi',
  -- },
  --
  -- {
  --   -- nearch with * for visual selection
  --   'thinca/vim-visualstar',
  -- },
  --
  -- {
  --   -- Better-escape: escape from insert mode something like jj without the usual delay
  --   'max397574/better-escape.nvim',
  --   opts = {
  --     default_mappings = false,
  --     mappings = {
  --       -- n = {
  --       --   -- Use kj to enter Julia block movement mode
  --       --   k = { j = 'kj' },
  --       -- },
  --       i = { -- Keymaps to exit insert mode
  --         j = { j = '<Esc>' },
  --       },
  --       c = { -- Keymaps to exit command mode
  --         j = {
  --           k = '<Esc>',
  --         },
  --       },
  --       t = { -- Keymaps to exit terminal mode
  --         j = {
  --           j = '<C-\\><C-n>',
  --         },
  --       },
  --       v = { -- Keymaps to exit visual mode
  --         j = {
  --           k = '<Esc>',
  --         },
  --       },
  --       s = { -- Keymaps to enter selection mode
  --         j = {
  --           k = '<Esc>',
  --         },
  --       },
  --     },
  --   },
  -- },
}
