return {
  {
    -- Colortheme: Nord
    'gbprod/nord.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'nord'

      -- Change background color to something darker, same as wezterm background
      vim.cmd 'highlight Normal guibg=#1e2128'
      -- Set custom colors for search and incsearch
      -- The default nord ones are too bright for my taste
      vim.api.nvim_set_hl(0, 'Search', { bg = '#555500', fg = 'white' })
      vim.api.nvim_set_hl(0, 'IncSearch', { bg = '#777700', fg = 'white' })

      -- Set border color between splits
      vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#434C5E', bg = 'NONE' })
    end,
  },

  {
    -- Colortheme: Oldworld
    'dgox16/oldworld.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
  },

  {
    -- Noice: Popup window for messages
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          -- bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },

  {
    -- Lualine: Customize statusline
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- I like nord
      local nord = {
        --16 colors
        black = '#2E3440', -- nord0 in palette
        dark_gray = '#3B4252', -- nord1 in palette
        gray = '#434C5E', -- nord2 in palette
        light_gray = '#4C566A', -- nord3 in palette
        light_gray_bright = '#616E88', -- out of palette
        darkest_white = '#D8DEE9', -- nord4 in palette
        darker_white = '#E5E9F0', -- nord5 in palette
        white = '#ECEFF4', -- nord6 in palette
        teal = '#8FBCBB', -- nord7 in palette
        off_blue = '#88C0D0', -- nord8 in palette
        glacier = '#81A1C1', -- nord9 in palette
        blue = '#5E81AC', -- nord10 in palette
        red = '#BF616A', -- nord11 in palette
        orange = '#D08770', -- nord12 in palette
        yellow = '#EBCB8B', -- nord13 in palette
        green = '#A3BE8C', -- nord14 in palette
        purple = '#B48EAD', -- nord15 in palette
        none = 'NONE',
        -- my own additions
        pink = '#b48da7', -- my own	addition
        bg = '#2E3440', -- A bit darker than nord's default background
      }

      -- Set colors for different vim modes
      local modecolor = {
        n = nord.glacier,
        i = nord.yellow,
        v = nord.purple,
        [''] = nord.purple,
        V = nord.red,
        c = nord.yellow,
        no = nord.red,
        s = nord.yellow,
        S = nord.yellow,
        [''] = nord.yellow,
        ic = nord.yellow,
        R = nord.green,
        Rv = nord.purple,
        cv = nord.red,
        ce = nord.red,
        r = nord.light_gray,
        rm = nord.light_gray,
        ['r?'] = nord.light_gray,
        ['!'] = nord.red,
        t = nord.yellow,
      }

      local theme = {
        normal = {
          a = { fg = nord.bg, bg = nord.blue },
          b = { fg = nord.blue, bg = nord.white },
          c = { fg = nord.white, bg = nord.bg },
          z = { fg = nord.white, bg = nord.bg },
        },
        insert = { a = { fg = nord.bg, bg = nord.orange } },
        visual = { a = { fg = nord.bg, bg = nord.green } },
        replace = { a = { fg = nord.bg, bg = nord.green } },
      }

      local space = {
        function()
          return ' '
        end,
        color = { bg = nord.bg },
      }

      local filename = {
        'filename',
        color = { bg = nord.blue, fg = nord.bg },
        separator = { left = '', right = '' },
      }

      local branch = {
        'branch',
        icon = '',
        color = { bg = nord.green, fg = nord.bg },
        separator = { left = '', right = '' },
      }

      local diff = {
        'diff',
        color = { bg = nord.bg, fg = nord.bg },
        separator = { left = '', right = '' },
        symbols = { added = ' ', modified = ' ', removed = ' ' },

        diff_color = {
          added = { fg = nord.green },
          modified = { fg = nord.yellow },
          removed = { fg = nord.pink },
        },
      }

      local modes = {
        'mode',
        color = function()
          local mode_color = modecolor
          return { bg = mode_color[vim.fn.mode()], fg = nord.bg }
        end,
        separator = { left = '', right = '' },
      }

      require('lualine').setup {
        options = {
          --
          --     -- globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'ministarter', 'snacks_dashboard' } },
          icons_enabled = true,
          theme = theme,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
        },

        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = { modes, space },
          lualine_y = { filename },
          lualine_z = { diff, space, branch },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },

  -- {
  --   -- Mini.HiPatterns: Add line to cells in notebooks
  --   'echasnovski/mini.hipatterns',
  --   event = 'VeryLazy',
  --   dependencies = { 'GCBallesteros/NotebookNavigator.nvim' },
  --
  --   opts = function()
  --     local nn = require 'notebook-navigator'
  --     local utils = require 'notebook-navigator.utils'
  --
  --     -- My own custom highlight group for code cells using Nord's yellow color
  --     vim.api.nvim_set_hl(0, 'NotebookCellHighlight', { fg = '#b48da7', bold = false })
  --
  --     local opts = {
  --       highlighters = {
  --         cell_delimiter = {
  --           -- Set the pattern to the cell marker as defined in NotebookNavigator plugin
  --           pattern = function(buf_id)
  --             local cell_marker = utils.get_cell_marker(buf_id, nn.config.cell_markers)
  --             if cell_marker then
  --               local regex_cell_marker = '^' .. cell_marker .. '%s*.*'
  --               return regex_cell_marker
  --             else
  --               return nil
  --             end
  --           end,
  --           -- Group name, doesn't really matter
  --           group = 'MiniHipatternsCustom',
  --           -- Calculate the length of the line to be added s.t. the total length is 80
  --           extmark_opts = function(_, match, _)
  --             local display_width = vim.fn.strdisplaywidth(match)
  --             local horizontal_line = {
  --               virt_text = { { string.rep('─', 80 - display_width), 'NotebookCellHighlight' } },
  --               line_hl_group = 'NotebookCellHighlight',
  --               hl_eol = true,
  --             }
  --             return horizontal_line
  --           end,
  --         },
  --       },
  --     }
  --     -- Apply the configuration only if a cell delimiter is defined in the Notebook Navigator config
  --     local cell_marker = utils.get_cell_marker(0, nn.config.cell_markers)
  --     if cell_marker then
  --       return opts
  --     else
  --       return {}
  --     end
  --   end,
  -- },

  {
    -- Which-Key: Keymap hints
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

  -- End of plugins
}
