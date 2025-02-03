return {

  -- Flash: Jump labels for faster navigation and selection
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      modes = {
        char = {
          -- Improved character navigation (e.g. `f`, `t`, `F`, `T`)
          enabled = true,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- Treewalker: Move in and out of nodes and between neighbours
  {
    'oscarvanderheide/treewalker.nvim',
    opts = {
      branch = 'oscar/select_node',
      highlight = true, -- default is false
    },
    dependencies = { 'nvimtools/hydra.nvim' },
    config = function(_, opts)
      local tw = require 'treewalker'
      local Hydra = require 'hydra'
      -- Set options to disable highlighting
      tw.setup(opts)

      Hydra {
        name = 'Treewalker',
        mode = { 'n', 'v' },
        body = '<leader>w',
        hint = [[Treewalker Hydra: 
  - _j_/_k_: Next/Previous node
  - _h_/_l_: In/Out of node
  - _v_: Select node
  - _q_/_<esc>_: Exit
        ]],
        config = {
          -- foreign_keys = nil,
          color = 'pink', -- "red" | "amaranth" | "teal" | "pink"
          invoke_on_body = true,
          hint = {
            position = 'bottom-right',
            offset = 1,
          },
        },
        heads = {
          -- Jump between nodes
          { 'j', tw.move_down, { desc = 'Move down', nowait = true } },
          { 'k', tw.move_up, { desc = 'Move up', nowait = true } },
          { 'l', tw.move_in, { desc = 'Move in', nowait = true } },
          { 'h', tw.move_out, { desc = 'Move out', nowait = true } },
          -- Actions on nodes
          { 'v', tw.select_node, { desc = 'Select node', nowait = true } },
          { 'V', tw.select_node_lines, { desc = 'Select node lines', nowait = true } },
          { 'c', tw.comment_node, { desc = 'Comment node', nowait = true } },
          { 'y', tw.yank_node, { desc = 'Yank node', nowait = true } },
          { 'd', tw.delete_node, { desc = 'Delete node', nowait = true } },
          -- Exit keys
          { 'q', nil, { exit = true, nowait = true, desc = 'Exit' } },
          { '<esc>', nil, { exit = true, nowait = true, desc = 'Exit' } },
        },
      }
    end,
  },

  -- Spider: Word movements that feel more natural to me (e.g. CamelCase is considered two words)
  {
    'chrisgrieser/nvim-spider',
    keys = {
      {
        'e',
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { 'n', 'o', 'x' },
      },
      {
        'w',
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { 'n', 'o', 'x' },
      },
      {
        'b',
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { 'n', 'o', 'x' },
      },
    },
  },

  -- Tabout: Move out of things like brackets with tab in insert mode
  {
    lazy = false,
    'abecodes/tabout.nvim',
    config = function()
      require('tabout').setup {
        tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = '<C-d>', -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = true, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = '`', close = '`' },
          { open = '(', close = ')' },
          { open = '[', close = ']' },
          { open = '{', close = '}' },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
      }
    end,
    dependencies = { -- These are optional
      'nvim-treesitter/nvim-treesitter',
      'zbirenbaum/copilot.lua',
      -- 'L3MON4D3/LuaSnip',
      -- 'hrsh7th/nvim-cmp',
    },
    opt = true, -- Set this to true if the plugin is optional
    event = 'InsertCharPre', -- Set the event to 'InsertCharPre' for better compatibility
    priority = 1000,
  },
  {
    'L3MON4D3/LuaSnip',
    keys = function()
      -- Disable default tab keybinding in LuaSnip
      return {}
    end,
  },
}
