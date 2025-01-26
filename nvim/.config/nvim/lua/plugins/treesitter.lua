return {
  { -- highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSupdate',
    main = 'nvim-treesitter.configs', -- sets main module to use for opts
    -- [[ configure treesitter ]] see `:help nvim-treesitter`
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      -- 'nvim-treesitter/nvim-treesitter-context', -- Shows e.g. function name on top for functions that extend beyond the screen
      'RRethy/nvim-treesitter-textsubjects',
      'RRethy/nvim-treesitter-endwise',
    },
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'julia',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'vim',
        'vimdoc',
      },
      -- autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        disable = { 'julia' }, -- disable tree-sitter for julia
        enable = true,
        -- some languages depend on vim's regex highlighting system (such as ruby) for indent rules.
        --  if you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      -- Options for treesitter textobjects
      textobjects = { -- Place textobjects here
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ['al'] = '@loop.outer',
            ['il'] = '@loop.inner',
            ['a='] = '@assignment.outer',
            ['i='] = '@assignment.inner',
            ['l='] = '@assignment.lhs',
            ['r='] = '@assignment.rhs',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          -- goto_next_start = {
          -- [']m'] = '@function.outer',
          -- [']]'] = { query = '@class.outer', desc = 'Next class start' },
          -- --
          -- -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
          -- [']o'] = '@loop.*',
          -- -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
          -- --
          -- -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
          -- -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
          -- [']s'] = { query = '@local.scope', query_group = 'locals', desc = 'Next scope' },
          -- [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
          --
          -- [']c'] = '@cell.boundary',
          -- },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          -- goto_previous_start = {
          --   ['[m'] = '@function.outer',
          --   ['[['] = '@class.outer',
          --
          --   ['[c'] = '@cell.boundary',
          -- },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
          -- Below will go to either the start or the end, whichever is closer.
          -- Use if you want more granular movements
          -- Make it even more gradual by adding multiple queries and regex.
          goto_next = {
            [']d'] = { query = { '@function.outer', '@class.outer' } },
            -- [']d'] = '@conditional.outer',
          },
          goto_previous = {
            ['[d'] = { query = { '@function.outer', '@class.outer' } },
          },
          -- Move between code cells
        },
        -- Additional textobject features (like move, swap) can go here
        -- swap = {
        --   enable = true,
        --   swap_next = {
        --     ['<leader>a'] = '@parameter.inner',
        --   },
        --   swap_previous = {
        --     ['<leader>A'] = '@parameter.inner',
        --   },
        -- },
      },

      -- Incrementally select the outer/inner nodes of a syntax tree
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-m>',
          scope_incremental = false,
          node_incremental = '<C-m>',
          node_decremental = '<C-n>',
        },
      },
      -- Automatically at "end" statements for things like functions, loops, etc.
      endwise = {
        enable = true,
      },
    },
    -- there are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. you should go explore a few and see what interests you:
    --
    --    - incremental selection: included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
}
-- vim: ts=2 sts=2 sw=2 et
