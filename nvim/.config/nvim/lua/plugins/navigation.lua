return {

  {
    -- Flash: Jump labels for faster navigation and selection
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

  {
    -- Treewalker: Move in and out of nodes and between neighbours
    -- 'oscarvanderheide/treewalker.nvim',
    dir = '/Users/oscar/tmp/treewalker.nvim',
    opts = {
      branch = 'oscar/select_node',
      highlight = true, -- default is false
    },
    dependencies = { 'nvimtools/hydra.nvim', 'nvim-treesitter/nvim-treesitter' },
    config = function(_, opts)
      local tw = require 'treewalker'
      local Hydra = require 'hydra'
      -- Set options to disable highlighting
      tw.setup(opts)

      Hydra {
        name = 'Treewalker',
        mode = { 'n', 'v' },
        body = '<leader>w',
        hint = 'Treewalker Hydra:\n'
          .. '- _j_/_k_: Next/Previous node\n'
          .. '- _h_/_l_: In/Out node \n'
          .. '- _v_: Select node\n'
          .. '- _y_: Yank node\n'
          .. '- _d_: Delete node\n'
          .. '- _c_: Comment node\n'
          .. '- _q_/_<esc>_: Exit',
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
          {
            'v',
            function()
              require('nvim-treesitter.incremental_selection').node_incremental()
            end,
            { desc = 'Visually select node', nowait = true, silent = true },
          },
          -- { 'V', tw.select_node_lines, { desc = 'Select node lines', nowait = true } },
          {
            'c',
            function()
              require('nvim-treesitter.incremental_selection').node_incremental()
              vim.cmd 'normal gc'
            end,
            { desc = 'Comment node', nowait = true, silent = true },
          },
          {
            'y',
            function()
              require('nvim-treesitter.incremental_selection').node_incremental()
              vim.cmd 'normal! y'
            end,
            { desc = 'Yank node', nowait = true, silent = true },
          },
          {
            'd',
            function()
              require('nvim-treesitter.incremental_selection').node_incremental()
              vim.cmd 'normal! d'
            end,
            { desc = 'Delete node', nowait = true, silent = true },
          },
          -- Exit keys
          { 'q', nil, { exit = true, nowait = true, desc = 'Exit' } },
          { '<esc>', nil, { exit = true, nowait = true, desc = 'Exit' } },
        },
      }
    end,
  },

  {
    -- Spider: Word movements that feel more natural to me (e.g. CamelCase is considered two words)
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
}
