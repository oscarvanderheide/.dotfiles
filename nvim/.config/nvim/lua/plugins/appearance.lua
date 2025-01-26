return {

  -- Nord: Colortheme
  -- {
  --   'comfysage/evergarden',
  --   priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
  --   opts = {
  --     transparent_background = true,
  --     variant = 'medium', -- 'hard'|'medium'|'soft'
  --     overrides = {}, -- add custom overrides
  --   },
  --   init = function()
  --     vim.cmd.colorscheme 'evergarden'
  --   end,
  -- },
  {
    'gbprod/nord.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'nord'
    end,
  },

  -- Lualine: Customize the statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local empty_lines = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      }
      require('lualine').setup {
        options = {
          refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
          },
        },
        sections = empty_lines,
        inactive_sections = empty_lines,
        tabline = empty_lines,
        winbar = {
          lualine_a = {},
          lualine_b = { 'filename' },
          lualine_c = {},
          lualine_x = {}, -- { 'filetype' },
          lualine_y = {
            function()
              return vim.fn.getcwd()
            end,
          },
          -- lualine_z = { { 'filename', path = 0 } }, --{ 'location' }
        },
        inactive_winbar = {
          lualine_a = {},
          lualine_b = { 'filename' },
          lualine_c = {},
          lualine_x = {}, -- { 'filetype' },
          lualine_y = {
            function()
              return vim.fn.getcwd()
            end,
          },
          -- lualine_z = { { 'filename', path = 0 } }, --{ 'location' }
        },
        extensions = {},
      }
    end,
  },

  -- Indent-Blankline: Visual indent lines
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },

  -- Illuminate: Highlight all instances of the word under the cursor
  -- {
  --   'RRethy/vim-illuminate',
  -- },

  -- Cinnamon: Smooth scrolling
  {
    'declancm/cinnamon.nvim',
    opts = {
      keymaps = {
        basic = true, -- enables a smooth scrolling for a few movements
        extra = false, -- additional movements, I think it's a bit too much
      },
    },
  },

  -- Smear: Smooth cursor movement
  {
    'sphamba/smear-cursor.nvim',
    opts = { -- Default  Range
      stiffness = 0.6, -- 0.6      [0, 1]
      trailing_stiffness = 0.3, -- 0.3      [0, 1]
      distance_stop_animating = 0.1, -- 0.1      > 0
      hide_target_hack = false, -- true     boolean
    },
  },

  -- Mini.HiPatterns: Add line to cells in notebooks
  {
    'echasnovski/mini.hipatterns',
    event = 'VeryLazy',
    dependencies = { 'GCBallesteros/NotebookNavigator.nvim' },
    opts = function()
      local nn = require 'notebook-navigator'

      local opts = { highlighters = { cells = nn.minihipatterns_spec } }
      return opts
    end,
  },

  -- Mini Clue: Keymap hints + hydra mode (note the "clues" are defined in configs of other plugins)
  -- {
  --   'echasnovski/mini.clue',
  --   version = '*',
  --   config = function()
  --     require('mini.clue').setup {
  --       triggers = {
  --         -- Leader triggers
  --         { mode = 'n', keys = '<Leader>' },
  --         { mode = 'x', keys = '<Leader>' },
  --
  --         -- Built-in completion
  --         { mode = 'i', keys = '<C-x>' },
  --
  --         -- `g` key
  --         { mode = 'n', keys = 'g' },
  --         { mode = 'x', keys = 'g' },
  --
  --         -- Marks
  --         { mode = 'n', keys = "'" },
  --         { mode = 'n', keys = '`' },
  --         { mode = 'x', keys = "'" },
  --         { mode = 'x', keys = '`' },
  --
  --         -- Registers
  --         { mode = 'n', keys = '"' },
  --         { mode = 'x', keys = '"' },
  --         { mode = 'i', keys = '<C-r>' },
  --         { mode = 'c', keys = '<C-r>' },
  --
  --         -- Window commands
  --         { mode = 'n', keys = '<C-w>' },
  --
  --         -- `z` key
  --         { mode = 'n', keys = 'z' },
  --         { mode = 'x', keys = 'z' },
  --       },
  --
  --       clues = {
  --         -- Enhance this by adding descriptions for <Leader> mapping groups
  --         require('mini.clue').gen_clues.builtin_completion(),
  --         require('mini.clue').gen_clues.g(),
  --         require('mini.clue').gen_clues.marks(),
  --         require('mini.clue').gen_clues.registers(),
  --         require('mini.clue').gen_clues.windows(),
  --         require('mini.clue').gen_clues.z(),
  --
  --         -- Treewalker navigation with postkeys to stay in submode
  --         { mode = 'n', keys = '<Leader>wj', postkeys = '<Leader>w', desc = 'Down' },
  --         { mode = 'n', keys = '<Leader>wk', postkeys = '<Leader>w', desc = 'Up' },
  --         { mode = 'n', keys = '<Leader>wh', postkeys = '<Leader>w', desc = 'Left' },
  --         { mode = 'n', keys = '<Leader>wl', postkeys = '<Leader>w', desc = 'Right' },
  --
  --         -- Notebook navigator with postkeys to stay in submode
  --         { mode = 'n', keys = '<Leader>hj', postkeys = '<Leader>h', desc = 'Down' },
  --         { mode = 'n', keys = '<Leader>hk', postkeys = '<Leader>h', desc = 'Up' },
  --         { mode = 'n', keys = '<Leader>hx', postkeys = '<Leader>h', desc = 'Execute' },
  --         { mode = 'n', keys = '<Leader>hX', postkeys = '<Leader>h', desc = 'Execute and Move' },
  --         { mode = 'n', keys = '<Leader>hc', postkeys = '<Leader>h', desc = 'Comment' },
  --       },
  --       -- Delay before showing clue window
  --       window = { -- Floating window config
  --         config = { width = 'auto' },
  --         delay = 300,
  --       },
  --     }
  --   end,
  -- },

  -- Which-Key: Keymap hints
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      icons = {
        mappings = vim.g.have_nerd_font,
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = {},
      },
    },
    -- Document existing key chains
    spec = {
      { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    },
  },
  -- Visimatch: Highlight all instances of the selected word
  {
    'wurli/visimatch.nvim',
    opts = {},
  },
  -- tpipeline: Integrate nvim statusline into tmux statusline
}
