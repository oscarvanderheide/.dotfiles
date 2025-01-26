return {
  {
    -- Iron: Interactive Repl (I kinda like the + operator)
    'Vigemus/iron.nvim',
    keys = {
      {
        '<leader>i',
        function()
          open_repl_float()
        end,
        desc = '󱠤 Open REPL (Float)',
      },
      {
        '<leader>I',
        function()
          open_repl_vertical()
        end,
        desc = '󱠤 Open REPL (Vertical Split)',
      },
      { '<leader>r', vim.cmd.IronRestart, desc = '󱠤 Restart REPL' },
      { '+', mode = { 'n', 'x' }, desc = '󱠤 Send-to-REPL Operator' },
    },
    config = function()
      local iron = require 'iron.core'
      local view = require 'iron.view'

      -- Function to open REPL in a floating window
      function open_repl_float()
        iron.setup {
          config = {
            scratch_repl = true,
            repl_open_cmd = function()
              local width = math.floor(vim.o.columns * 0.4)
              local height = math.floor(vim.o.lines * 0.3)
              local row = 1
              local col = vim.o.columns - width - 1
              local buf = vim.api.nvim_create_buf(false, true)
              vim.api.nvim_set_hl(0, 'CustomFloatBG', { bg = '#1e1e2e' })
              local win = vim.api.nvim_open_win(buf, true, {
                relative = 'editor',
                width = width,
                height = height,
                row = row,
                col = col,
                style = 'minimal',
              })
              vim.api.nvim_win_set_option(win, 'winhl', 'Normal:CustomFloatBG')
              return win
            end,
          },
        }
        vim.cmd.IronRepl()
      end

      -- Function to open REPL in a vertical split
      function open_repl_vertical()
        iron.setup {
          config = {
            scratch_repl = true,
            repl_open_cmd = view.split.vertical.botright(0.45),
          },
        }
        vim.cmd.IronRepl()
      end

      iron.setup {
        config = {
          scratch_repl = true,
          repl_open_cmd = view.split.vertical.botright(0.45),
          repl_definition = {
            python = {
              format = require('iron.fts.common').bracketed_paste,
              command = { 'uv', 'run', 'ipython', '--no-autoindent' },
            },
            julia = {
              command = { 'julia', '--project=.' },
            },
            lua = {
              command = { 'lua' },
            },
          },
        },
        ignore_blank_lines = true,
        keymaps = {
          send_motion = '+',
          visual_send = '+',
          send_line = '++',
          send_until_cursor = '<space>su',
        },
      }
    end,
  },
}
-- return {
--   {
--     -- Iron: Interactive Repl (I kinda like the + operator)
--     'Vigemus/iron.nvim',
--     keys = {
--       { '<leader>i', vim.cmd.IronRepl, desc = '󱠤 Open REPL' },
--       { '<leader>I', vim.cmd.IronRestart, desc = '󱠤 Restart REPL' },
--       { '+', mode = { 'n', 'x' }, desc = '󱠤 Send-to-REPL Operator' },
--       -- { '++', desc = '󱠤 Send Line to REPL' },
--     },
--     config = function()
--       local iron = require 'iron.core'
--       local view = require 'iron.view'
--
--       -- Set up Iron with specific configurations
--       iron.setup {
--         config = {
--           scratch_repl = true, -- Allow creating a scratch REPL
--
--           -- Open REPL in a vertical split at the bottom right
--           -- repl_open_cmd = view.split.vertical.botright(0.45),
--           repl_open_cmd = function()
--             -- Window dimensions
--             local width = math.floor(vim.o.columns * 0.4) -- 40% of screen width
--             local height = math.floor(vim.o.lines * 0.3) -- 30% of screen height
--
--             -- Window position (top-right corner)
--             local row = 1 -- 1 line from the top
--             local col = vim.o.columns - width - 1 -- Align to the right
--
--             -- Create a new scratch buffer
--             local buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
--
--             -- Create a custom highlight group for the background color
--             vim.api.nvim_set_hl(0, 'CustomFloatBG', { bg = '#1e1e2e' }) -- Change to your desired color
--             -- Open the floating window
--             local win = vim.api.nvim_open_win(buf, true, {
--               relative = 'editor',
--               width = width,
--               height = height,
--               row = row,
--               col = col,
--               style = 'minimal',
--               -- border = 'rounded', -- Border style ('rounded', 'double', etc.)
--             })
--
--             -- Apply the custom highlight group to the floating window
--             vim.api.nvim_win_set_option(win, 'winhl', 'Normal:CustomFloatBG')
--             return win -- Return the window handle for Iron.nvim to use
--           end,
--           -- Language-specific configurations
--           repl_definition = {
--             python = {
--               format = require('iron.fts.common').bracketed_paste,
--               command = { 'uv', 'run', 'ipython', '--no-autoindent' },
--             },
--             julia = {
--               command = { 'julia', '--project=.' },
--             },
--             lua = {
--               command = { 'lua' },
--             },
--           },
--         },
--
--         ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
--         keymaps = {
--           send_motion = '+',
--           visual_send = '+',
--           -- send_file = '<space>sf',
--           send_line = '++',
--           -- send_paragraph = 'M',
--           send_until_cursor = '<space>su',
--           -- send_mark = '<space>sm',
--           -- mark_motion = '<space>mc',
--           -- mark_visual = '<space>mc',
--           -- remove_mark = '<space>md',
--           -- cr = '<space>s<cr>',
--           -- interrupt = '<space>s<space>',
--           -- exit = '<space>sq',
--           -- clear = '<space>cl',
--         },
--       }
--     end,
--   },
--
--   -- Notebook Navigator: Quickly jump between and execute code cells
--   {
--     'GCBallesteros/NotebookNavigator.nvim',
--     -- keys = {
--     --   { '<leader>hX', "<cmd>lua require('notebook-navigator').run_cell()<cr>", silent = true, desc = 'Run Cell' },
--     --   { '<leader>hx', "<cmd>lua require('notebook-navigator').run_and_move()<cr>", desc = 'Run Cell and Move' },
--     --   { '<leader>hj', "<cmd>lua require('notebook-navigator').move_cell('d')<cr>", desc = 'Move down' },
--     --   { '<leader>hk', "<cmd>lua require('notebook-navigator').move_cell('u')<cr>", desc = 'Move up' },
--     --   { '<leader>hc', "<cmd>lua require('notebook-navigator').comment_cell()<cr>", desc = 'Comment cell' },
--     -- },
--
--     dependencies = {
--       'echasnovski/mini.comment',
--       'hkupty/iron.nvim', -- REPL provider, can also use molten or toggleterm
--       -- 'benlubas/molten-nvim',
--       -- 'akinsho/toggleterm.nvim',
--       'anuvyklack/hydra.nvim',
--     },
--     event = 'VeryLazy',
--
--     config = function()
--       local nn = require 'notebook-navigator'
--       nn.setup {
--         activate_hydra_keys = 'h',
--         cell_markers = {
--           julia = '##', -- Set the code cell marker for Julia
--           python = '##',
--         },
--         repl_provider = 'iron',
--         syntax_highlight = true,
--         -- (Optional) for use with `mini.hipatterns` to highlight cell markers
--         cell_highlight_group = 'Folded',
--       }
--     end,
--   },
--   {
--     -- Enable things like vih to select code cells
--     'echasnovski/mini.ai',
--     event = 'VeryLazy',
--     dependencies = { 'GCBallesteros/NotebookNavigator.nvim' },
--     opts = function()
--       local nn = require 'notebook-navigator'
--
--       local opts = { custom_textobjects = { h = nn.miniai_spec } }
--       return opts
--     end,
--   },
--   -- {
--   --   -- Enable things like vih to select code cells
--   --   'echasnovski/mini.ai',
--   --   event = 'VeryLazy',
--   --   dependencies = { 'GCBallesteros/NotebookNavigator.nvim' },
--   --   opts = function()
--   --     local nn = require 'notebook-navigator'
--   --     local opts = { custom_textobjects = { h = nn.miniai_spec } }
--   --     return opts
--   --   end,
--   -- },
-- }
