return {
  {
    -- Blink: Completion engine
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets', 'onsails/lspkind.nvim' },
    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      -- My super-TAB configuration
      keymap = {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<C-CR>'] = { 'accept', 'fallback' },
        ['<C-y>'] = { 'accept', 'fallback' },
        -- ['<Tab>'] = {
        --   function(cmp)
        --     return cmp.select_next()
        --   end,
        --   'snippet_forward',
        --   'fallback',
        -- },
        -- ['<S-Tab>'] = {
        --   function(cmp)
        --     return cmp.select_prev()
        --   end,
        --   'snippet_backward',
        --   'fallback',
        -- },
        --
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<C-up>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-down>'] = { 'scroll_documentation_down', 'fallback' },
      },
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = false,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        accept = { auto_brackets = { enabled = true } },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 250,
          treesitter_highlighting = true,
          window = { border = 'rounded' },
        },

        list = {
          selection = { auto_insert = true, preselect = true },
        },

        menu = {
          border = 'rounded',

          auto_show = function(ctx)
            return ctx.mode ~= 'cmdline' or not vim.tbl_contains({ '/', '?' }, vim.fn.getcmdtype())
          end,
          cmdline_position = function()
            if vim.g.ui_cmdline_pos ~= nil then
              local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
              return { pos[1] - 1, pos[2] }
            end
            local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
            return { vim.o.lines - height, 0 }
          end,

          draw = {
            columns = {
              { 'kind_icon', 'label', gap = 1 },
              { 'kind' },
            },
            components = {
              kind_icon = {
                text = function(item)
                  local kind = require('lspkind').symbol_map[item.kind] or ''
                  return kind .. ' '
                end,
                highlight = 'CmpItemKind',
              },
              label = {
                text = function(item)
                  return item.label
                end,
                highlight = 'CmpItemAbbr',
              },
              kind = {
                text = function(item)
                  return item.kind
                end,
                highlight = 'CmpItemKind',
              },
            },
          },
        },
      },
      -- Experimental signature help support (no idea wtf this is)
      signature = {
        enabled = true,
        window = { border = 'rounded' },
      },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        -- cmdline = function()
        --   local type = vim.fn.getcmdtype()
        --   -- Search forward and backward
        --   if type == '/' or type == '?' then
        --     return { 'buffer' }
        --   end
        --   -- Commands
        --   if type == ':' then
        --     return { 'cmdline' }
        --   end
        --   return {}
        -- end,
        providers = {
          lsp = {
            min_keyword_length = 2, -- Number of characters to trigger porvider
            score_offset = 0, -- Boost/penalize the score of the items
          },
          path = {
            min_keyword_length = 0,
          },
          snippets = {
            min_keyword_length = 2,
          },
          buffer = {
            min_keyword_length = 3,
            max_items = 5,
          },
        },
        -- providers = {
        --   copilot = {
        --     name = 'copilot',
        --     module = 'blink-cmp-copilot',
        --     score_offset = 100,
        --     async = true,
        --   },
        -- },
      },
    },
    opts_extend = { 'sources.default' },
  },

  {
    -- Blink.cmp copilot provider
    'giuxtaposition/blink-cmp-copilot',
  },
}
