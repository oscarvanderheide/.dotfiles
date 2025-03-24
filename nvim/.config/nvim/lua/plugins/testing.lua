return {

  -- {
  --   'luiscassih/AniKakoune',
  --   event = 'VeryLazy',
  --   config = function()
  --     require('AniMotion').setup {
  --       mode = 'animotion', -- "nvim" or "helix"
  --       word_keys = {
  --         [1] = 'w',
  --         [2] = 'e',
  --         [3] = 'b',
  --         [4] = 'W',
  --         [5] = 'E',
  --         [6] = 'B',
  --       }, -- you can get the targets by local Utils = require("Animotion.Utils")
  --       edit_keys = { 'c', 'd', 'r', 'y', 'p' }, -- you can add "p" if you want.
  --       clear_keys = { '<Esc>' }, -- used when you want to deselect/exit from SEL mode.
  --       marks = { 'y', 'z' }, -- Is a mark used internally in this plugin, when we do a visual select when changing or deleting the highlighted word.
  --       map_visual = true, -- When true, we capture "v" and pressing it will enter visual mode with the plugin selection as part of the visual selection. When false, pressing "v" will exit SEL mode and the selection will be lost. You want to set to false if you have trouble with other mappings associated to "v". I recommend to try in true first.
  --       color = { bg = '#673AB7' }, -- put color = "Visual" to use the default visual mode color. You can also customize via vim.api.nvim_set_hl(0, "@AniMotion", hl_color)
  --     }
  --   end,
  -- },
  -- {
  --   -- Tiny-glimmer: fading highlights for yank/undo/redo - BUT CANT GET IT TO WORK FOR THE LIFE OF M
  --   'rachartier/tiny-glimmer.nvim',
  --   event = 'VeryLazy',
  --   keys = {
  --     {
  --       'u',
  --       function()
  --         require('tiny-glimmer').undo()
  --       end,
  --       { noremap = true, silent = true },
  --     },
  --   },
  --   opts = {},
  --
  --   config = function()
  --     require('tiny-glimmer').setup {
  --       enabled = true,
  --
  --       -- Disable this if you wants to debug highlighting issues
  --       disable_warnings = false,
  --       overwrite = {
  --         auto_map = false,
  --         search = {
  --           enabled = true,
  --           -- default_animation = 'pulse',
  --           -- Keys to navigate to the next match
  --           -- next_mapping = 'nzzzv',
  --           -- Keys to navigate to the previous match
  --           -- prev_mapping = 'Nzzzv',
  --         },
  --         undo = {
  --           enabled = true,
  --           undo_mapping = 'u',
  --           -- default_animation = 'pulse',
  --           -- Keys to navigate to the next match
  --           -- next_mapping = 'nzzzv',
  --           -- Keys to navigate to the previous match
  --           -- prev_mapping = 'Nzzzv',
  --         },
  --       },
  --     }
  --   end,
  --   -- config = function()
  --   --   require('tiny-glimmer').setup {
  --   --   -- your configuration
  --   --   overwrite = {
  --   --     auto_map = false,
  --   --     undo = {
  --   --       enabled = true,
  --   --       -- default_animation = 'pulse',
  --   --
  --   --       -- Keys to navigate to the next match
  --   --       -- next_mapping = 'nzzzv',
  --   --
  --   --       -- Keys to navigate to the previous match
  --   --       -- prev_mapping = 'Nzzzv',
  --   --     },
  --   --   },
  --   --   }
  --   --   end
  --   -- },
  -- },
  -- {
  --   -- Namu: A symbol picker for LSP symbols
  --   'bassamsdata/namu.nvim',
  --   config = function()
  --     require('namu').setup {
  --       -- Enable the modules you want
  --       namu_symbols = {
  --         enable = true,
  --         options = { -- here you can configure namu
  --           movement = {
  --             next = { '<C-j>', '<DOWN>' }, -- Support multiple keys
  --             previous = { '<C-n>', '<UP>' }, -- Support multiple keys
  --             close = { '<ESC>' }, -- close mapping
  --             select = { '<CR>' }, -- select mapping
  --             delete_word = {}, -- delete word mapping
  --             clear_line = {}, -- clear line mapping
  --           }, -- add any options here
  --         },
  --       },
  --       -- Optional: Enable other modules if needed
  --       colorscheme = {
  --         enable = false,
  --         options = {
  --           persist = true, -- very efficient mechanism to Remember selected colorscheme
  --           write_shada = false, -- If you open multiple nvim instances, then probably you need to enable this
  --         },
  --       },
  --       ui_select = { enable = false }, -- vim.ui.select() wrapper
  --     }
  --     -- === Suggested Keymaps: ===
  --     local namu = require 'namu.namu_symbols'
  --     local colorscheme = require 'namu.colorscheme'
  --     vim.keymap.set('n', '<leader>f', namu.show, {
  --       desc = 'Jump to LSP symbol',
  --       silent = true,
  --     })
  --     vim.keymap.set('n', '<leader>th', colorscheme.show, {
  --       desc = 'Colorscheme Picker',
  --       silent = true,
  --     })
  --   end,
  -- },
  {
    'tanvirtin/vgit.nvim',
    branch = 'v1.0.x',
    -- or               , tag = 'v1.0.2',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
    -- Lazy loading on 'VimEnter' event is necessary.
    event = 'VimEnter',
    config = function()
      require('vgit').setup {
        keymaps = {
          ['n <C-k>'] = function()
            require('vgit').hunk_up()
          end,
          ['n <C-j>'] = function()
            require('vgit').hunk_down()
          end,
          ['n <leader>gs'] = function()
            require('vgit').buffer_hunk_stage()
          end,
          ['n <leader>gr'] = function()
            require('vgit').buffer_hunk_reset()
          end,
          ['n <leader>gp'] = function()
            require('vgit').buffer_hunk_preview()
          end,
          ['n <leader>gb'] = 'buffer_blame_preview',
          ['n <leader>gf'] = function()
            require('vgit').buffer_diff_preview()
          end,
          ['n <leader>gh'] = function()
            require('vgit').buffer_history_preview()
          end,
          ['n <leader>gu'] = function()
            require('vgit').buffer_reset()
          end,
          ['n <leader>gd'] = function()
            require('vgit').project_diff_preview()
          end,
          ['n <leader>gx'] = function()
            require('vgit').toggle_diff_preference()
          end,
        },
      }
    end,
  },
  -- Tabout: Move out of things like brackets with tab in insert mode
  -- {
  --   lazy = false,
  --   'abecodes/tabout.nvim',
  --   config = function()
  --     require('tabout').setup {
  --       tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
  --       backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
  --       act_as_tab = true, -- shift content if tab out is not possible
  --       act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
  --       default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
  --       default_shift_tab = '<C-d>', -- reverse shift default action,
  --       enable_backwards = true, -- well ...
  --       completion = true, -- if the tabkey is used in a completion pum
  --       tabouts = {
  --         { open = "'", close = "'" },
  --         { open = '"', close = '"' },
  --         { open = '`', close = '`' },
  --         { open = '(', close = ')' },
  --         { open = '[', close = ']' },
  --         { open = '{', close = '}' },
  --       },
  --       ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
  --       exclude = {}, -- tabout will ignore these filetypes
  --     }
  --   end,
  --   dependencies = { -- These are optional
  --     'nvim-treesitter/nvim-treesitter',
  --     'zbirenbaum/copilot.lua',
  --     -- 'L3MON4D3/LuaSnip',
  --     -- 'hrsh7th/nvim-cmp',
  --   },
  --   opt = true, -- Set this to true if the plugin is optional
  --   event = 'InsertCharPre', -- Set the event to 'InsertCharPre' for better compatibility
  --   priority = 1000,
  -- },

  -- Evergarden: Colortheme
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
  -- Visimatch: Highlight all instances of the selected word
  -- {
  --   'wurli/visimatch.nvim',
  --   opts = {},
  -- },
  -- tpipeline: Integrate nvim statusline into tmux statusline

  -- Illuminate: Highlight all instances of the word under the cursor
  -- {
  --   'RRethy/vim-illuminate',
  -- },

  -- Cinnamon: Smooth scrolling
  -- {
  --   'declancm/cinnamon.nvim',
  --   config = function()
  --     local cinnamon = require 'cinnamon'
  --     cinnamon.setup {
  --       disabled = false,
  --       keymaps = {
  --         basic = false, -- enables smooth scrolling for a few movements, disabled for now
  --         extra = false, -- additional movements, I think it's a bit too much
  --       },
  --       options = { -- Delay between each movement step (in ms)
  --         delay = 5,
  --         max_delta = {
  --           -- Maximum distance for line movements before scroll
  --           -- animation is skipped. Set to `false` to disable
  --           line = false,
  --           -- Maximum distance for column movements before scroll
  --           -- animation is skipped. Set to `false` to disable
  --           column = false,
  --           -- Maximum duration for a movement (in ms). Automatically scales the
  --           -- delay and step size
  --           time = 2000,
  --         },
  --       },
  --     }
  --
  --     -- Centered scrolling:
  --     vim.keymap.set('n', '<C-U>', function()
  --       cinnamon.scroll '<C-U>zz'
  --     end)
  --     vim.keymap.set('n', '<C-D>', function()
  --       cinnamon.scroll '<C-D>zz'
  --     end)
  --   end,
  -- },

  -- Smear: Smooth cursor movement
  -- {
  --   'sphamba/smear-cursor.nvim',
  --   opts = { -- Default  Range
  --     stiffness = 0.6, -- 0.6      [0, 1]
  --     trailing_stiffness = 0.3, -- 0.3      [0, 1]
  --     distance_stop_animating = 0.1, -- 0.1      > 0
  --     hide_target_hack = false, -- true     boolean
  --   },
  -- },

  -- {
  -- Autopairs: automatically adds closing ),] or } (disabled because it annoyed me)
  -- 'windwp/nvim-autopairs',
  -- event = 'InsertEnter',
  -- -- Optional dependency
  -- dependencies = { 'hrsh7th/nvim-cmp' },
  -- config = function()
  --   require('nvim-autopairs').setup {}
  --   -- If you want to automatically add `(` after selecting a function or method
  --   local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
  --   local cmp = require 'cmp'
  --   cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  -- end,
  -- },
  -- Neogen: Automatically add docstrings to your functions
  -- {
  --   'danymat/neogen',
  --   config = true,
  --   -- Uncomment next line if you want to follow only stable versions
  --   -- version = "*",
  --   keys = {
  --     { '<Leader>nf', ":lua require('neogen').generate()<CR>" },
  --   },
  -- },
}
