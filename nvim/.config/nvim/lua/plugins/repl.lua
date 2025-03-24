return {

  {
    -- Iron: Interactive Repl (I kinda like the + operator)
    'Vigemus/iron.nvim',
    keys = {
      -- Keymaps to either open REPL in a floating window or as a vertical split
      -- The keymap <leader>rr is then used to toggle, respecting how it was opened
      {
        '<leader>rf',
        function()
          open_repl_float()
        end,
        desc = '󱠤 Open REPL (Float)',
      },
      {
        '<leader>rs',
        function()
          -- Close all splits first (optional)
          vim.cmd 'only'
          -- Open left buffer (normal)
          vim.cmd 'vsplit'
          -- Move to right buffer
          vim.cmd 'wincmd l'

          -- Remove gutter in top-right buffer
          -- vim.opt_local.number = false
          -- vim.opt_local.relativenumber = false
          vim.opt_local.signcolumn = 'no'
          -- Open Python REPL (ToggleTerm) in horizontal split
          open_repl_horizontal()
        end,

        desc = 'Set up split layout with Python REPL',
      },

      {
        'X',
        -- send line to repl and mvoe to next line
        function()
          vim.cmd 'IronSendLine'
          vim.cmd 'normal! j'
        end,
        mode = { 'n' },
        desc = '󱠤 Send-to-REPL Operator',
      },
      --   { '<leader>rr', vim.cmd.IronRepl, desc = '󱠤 Toggle REPL' },
      --   { '<leader>rR', vim.cmd.IronRestart, desc = '󱠤 Restart REPL' },
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

      function open_repl_horizontal()
        iron.setup {
          config = {
            scratch_repl = true,
            repl_open_cmd = view.split.horizontal.rightbelow(0.4),
          },
        }
        vim.cmd.IronRepl()
      end

      iron.setup {
        config = {
          scratch_repl = true,
          -- See docs: repl_open_cmd can be a table
          -- set the file type of the newly created repl to ft
          -- bufnr is the buffer id of the REPL and ft is the filetype of the
          -- language being used for the REPL.
          repl_filetype = function(bufnr, ft)
            -- return ft
            -- or return a string name such as the following
            return 'iron'
          end,
          repl_open_cmd = {
            view.split.vertical.botright(0.45),
            view.split.rightbelow '%40',
          },
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
            bash = {
              command = { 'pwd' },
            },
          },
        },
        ignore_blank_lines = true,
        keymaps = {
          send_motion = '+',
          visual_send = '+',
          send_line = '++',
          send_until_cursor = '<space>su',
          toggle_repl_with_cmd_1 = '<leader>rv',
          toggle_repl_with_cmd_2 = '<leader>rh',
          send_paragraph = '<D-x>',
        },
      }
    end,

    -- { '+', mode = { 'n', 'x' }, desc = '󱠤 Send-to-REPL Operator' },
    --
    -- { '<leader>rr', vim.cmd.IronRepl, desc = '󱠤 Toggle REPL' },
    -- { '<leader>rR', vim.cmd.IronRestart, desc = '󱠤 Restart REPL' },
    -- },
    -- config = function()
    --   local iron = require 'iron.core'
    --   local view = require 'iron.view'
    --
    --   -- Function to open REPL in a floating window
    --   function open_repl_float()
    --     iron.setup {
    --       config = {
    --         scratch_repl = true,
    --         repl_open_cmd = function()
    --           local width = math.floor(vim.o.columns * 0.4)
    --           local height = math.floor(vim.o.lines * 0.3)
    --           local row = 1
    --           local col = vim.o.columns - width - 1
    --           local buf = vim.api.nvim_create_buf(false, true)
    --           vim.api.nvim_set_hl(0, 'CustomFloatBG', { bg = '#1e1e2e' })
    --           local win = vim.api.nvim_open_win(buf, true, {
    --             relative = 'editor',
    --             width = width,
    --             height = height,
    --             row = row,
    --             col = col,
    --             style = 'minimal',
    --           })
    --           vim.api.nvim_win_set_option(win, 'winhl', 'Normal:CustomFloatBG')
    --           return win
    --         end,
    --       },
    --     }
    --     vim.cmd.IronRepl()
    --   end
    --
    --   function open_repl_horizontal()
    --     iron.setup {
    --       config = {
    --         scratch_repl = true,
    --         repl_open_cmd = view.split.horizontal.botright(0.45),
    --       },
    --     }
    --     vim.cmd.IronRepl()
    --   end
    --
    --   -- Function to open REPL in a vertical split
    --   function open_repl_vertical()
    --     iron.setup {
    --       config = {
    --         scratch_repl = true,
    --         repl_open_cmd = view.split.vertical.botright(0.45),
    --       },
    --     }
    --     vim.cmd.IronRepl()
    --   end
    --
    --   iron.setup {
    --     config = {
    --       scratch_repl = true,
    --       repl_open_cmd = view.split.vertical.botright(0.45),
    --       repl_definition = {
    --         python = {
    --           format = require('iron.fts.common').bracketed_paste,
    --           command = { 'uv', 'run', 'ipython', '--no-autoindent' },
    --         },
    --         julia = {
    --           command = { 'julia', '--project=.' },
    --         },
    --         lua = {
    --           command = { 'lua' },
    --         },
    --         bash = {
    --           command = { 'pwd' },
    --         },
    --       },
    --     },
    --     ignore_blank_lines = true,
    --     keymaps = {
    --       send_motion = '+',
    --       visual_send = '+',
    --       send_line = '++',
    --       send_until_cursor = '<space>su',
    --     },
    --   }
    -- end,
  },

  {
    -- Notebook Navigator: Quickly jump between and execute code cells
    'oscarvanderheide/NotebookNavigator.nvim',
    dependencies = {
      'echasnovski/mini.comment',
      'hkupty/iron.nvim', -- REPL provider, can also use molten or toggleterm
      -- 'benlubas/molten-nvim',
      -- 'akinsho/toggleterm.nvim',
      'anuvyklack/hydra.nvim',
    },
    event = 'VeryLazy',

    config = function()
      local nn = require 'notebook-navigator'
      local utils = require 'notebook-navigator.utils'

      nn.setup {
        activate_hydra_keys = '<leader>n',
        cell_markers = {
          julia = '##', -- Set the code cell marker for Julia
          python = '# %%', -- Set the code cell markers for Python
          lua = '--##', -- Set the code cell markers for Lua
          cpp = '/*##', -- Set the code cell markers for C++
        },
        repl_provider = 'iron',
        syntax_highlight = false, -- Set custom highlight group for code cells
        -- cell_highlight_group = 'Folded', -- I define my own in appearance.lua
      }
    end,
    -- Now, override minihipatterns_spec after setup has run
  },
}
