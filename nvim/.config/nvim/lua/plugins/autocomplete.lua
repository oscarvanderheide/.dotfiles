return {
  {
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
        cmdline = function()
          local type = vim.fn.getcmdtype()
          -- Search forward and backward
          if type == '/' or type == '?' then
            return { 'buffer' }
          end
          -- Commands
          if type == ':' then
            return { 'cmdline' }
          end
          return {}
        end,
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
    'giuxtaposition/blink-cmp-copilot',
  },
}
-- -- cmp: autocomplete
-- return {
--   { -- Autocompletion
--     'hrsh7th/nvim-cmp',
--     event = 'InsertEnter',
--     dependencies = {
--       -- Snippet Engine & its associated nvim-cmp source
--       {
--         'L3MON4D3/LuaSnip',
--         build = (function()
--           -- Build Step is needed for regex support in snippets.
--           -- This step is not supported in many windows environments.
--           -- Remove the below condition to re-enable on windows.
--           if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
--             return
--           end
--           return 'make install_jsregexp'
--         end)(),
--         dependencies = {
--           -- `friendly-snippets` contains a variety of premade snippets.
--           --    See the README about individual language/framework/plugin snippets:
--           --    https://github.com/rafamadriz/friendly-snippets
--           -- {
--           --   'rafamadriz/friendly-snippets',
--           --   config = function()
--           --     require('luasnip.loaders.from_vscode').lazy_load()
--           --   end,
--           -- },
--         },
--       },
--       'saadparwaiz1/cmp_luasnip',
--
--       -- Adds other completion capabilities.
--       --  nvim-cmp does not ship with all sources by default. They are split
--       --  into multiple repos for maintenance purposes.
--       'hrsh7th/cmp-nvim-lsp',
--       'hrsh7th/cmp-path',
--     },
--     config = function()
--       -- See `:help cmp`
--       local cmp = require 'cmp'
--       local luasnip = require 'luasnip'
--       luasnip.config.setup {}
--
--       local has_copilot, copilot_suggestion = pcall(require, 'copilot.suggestion')
--       local cmp_select_opts = { behavior = cmp.SelectBehavior.Replace }
--       local has_luasnip, luasnip = pcall(require, 'luasnip')
--       cmp.setup {
--         snippet = {
--           expand = function(args)
--             luasnip.lsp_expand(args.body)
--           end,
--         },
--         completion = { completeopt = 'menu,menuone,noinsert' },
--
--         -- For an understanding of why these mappings were
--         -- chosen, you will need to read `:help ins-completion`
--         --
--         -- No, but seriously. Please read `:help ins-completion`, it is really good!
--         mapping = cmp.mapping.preset.insert {
--           -- Select the [n]ext item
--           ['<C-n>'] = cmp.mapping.select_next_item(),
--           -- Select the [p]revious item
--           ['<C-p>'] = cmp.mapping.select_prev_item(),
--
--           -- Scroll the documentation window [b]ack / [f]orward
--           ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--           ['<C-f>'] = cmp.mapping.scroll_docs(4),
--
--           -- Accept ([y]es) the completion.
--           --  This will auto-import if your LSP supports it.
--           --  This will expand snippets if the LSP sent a snippet.
--           ['<C-y>'] = cmp.mapping.confirm { select = true },
--
--           -- If you prefer more traditional completion keymaps,
--           -- you can uncomment the following lines
--           -- ['<CR>'] = cmp.mapping.confirm { select = true },
--           -- ['<Tab>'] = cmp.mapping.select_next_item(),
--           -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),
--           --
--           ['<Tab>'] = cmp.mapping(function(fallback)
--             local col = vim.fn.col '.' - 1
--
--             if has_copilot and copilot_suggestion.is_visible() then
--               copilot_suggestion.accept()
--             elseif cmp.visible() then
--               -- cmp.select_next_item(cmp_select_opts)
--               cmp.mapping.confirm {
--                 select = true,
--               }
--             elseif has_luasnip and luasnip.expand_or_jumpable() then
--               luasnip.expand_or_jump()
--             elseif col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' then
--               fallback()
--             else
--               -- cmp.complete()
--               cmp.mapping.confirm { select = true }
--             end
--           end, { 'i', 's' }),
--           -- Manually trigger a completion from nvim-cmp.
--           --  Generally you don't need this, because nvim-cmp will display
--           --  completions whenever it has completion options available.
--           ['<C-Space>'] = cmp.mapping.complete {},
--
--           -- Think of <c-l> as moving to the right of your snippet expansion.
--           --  So if you have a snippet that's like:
--           --  function $name($args)
--           --    $body
--           --  end
--           --
--           -- <c-l> will move you to the right of each of the expansion locations.
--           -- <c-h> is similar, except moving you backwards.
--           ['<C-l>'] = cmp.mapping(function()
--             if luasnip.expand_or_locally_jumpable() then
--               luasnip.expand_or_jump()
--             end
--           end, { 'i', 's' }),
--           ['<C-h>'] = cmp.mapping(function()
--             if luasnip.locally_jumpable(-1) then
--               luasnip.jump(-1)
--             end
--           end, { 'i', 's' }),
--
--           -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
--           --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
--         },
--         sources = {
--           {
--             name = 'lazydev',
--             -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
--             group_index = 0,
--           },
--           { name = 'nvim_lsp' },
--           { name = 'luasnip' },
--           { name = 'path' },
--         },
--       }
--
--       -- hide copilot suggestions when cmp menu is open
--       -- to prevent odd behavior/garbled up suggestions
--       local cmp_status_ok, cmp = pcall(require, 'cmp')
--       if cmp_status_ok then
--         cmp.event:on('menu_opened', function()
--           vim.b.copilot_suggestion_hidden = true
--         end)
--
--         cmp.event:on('menu_closed', function()
--           vim.b.copilot_suggestion_hidden = false
--         end)
--       end
--     end,
--   },
-- }
-- -- vim: ts=2 sts=2 sw=2 et
