return {
  {
    'echasnovski/mini.ai',
    event = 'VeryLazy', -- Load only when needed
    dependencies = { 'GCBallesteros/NotebookNavigator.nvim' },
    opts = function()
      -- Enable things like vih to select code cells
      local nn = require 'notebook-navigator'
      local opts = { custom_textobjects = { h = nn.miniai_spec } }

      return opts
    end,
    config = function()
      local queries = require 'nvim-treesitter.query'

      local miniAiTreesitter = function(ai_type, _, _, query_list)
        ai_type = ai_type == 'a' and '.outer' or '.inner'
        query_list = vim.tbl_map(function(query)
          return query .. ai_type
        end, query_list)

        local matches = {}
        for _, query in pairs(query_list) do
          vim.list_extend(matches, queries.get_capture_matches_recursively(0, query, 'textobjects'))
        end

        matches = vim.tbl_map(function(match)
          local from_line, from_col, to_line, to_col = match.node:range()
          return {
            from = { line = from_line + 1, col = from_col + 1 },
            to = { line = to_line + 1, col = to_col + 1 },
          }
        end, matches)

        return matches
      end

      local miniAiTreeWrapper = function(query_list)
        if type(query_list) ~= 'table' then
          query_list = { query_list }
        end
        return function(ai_type, _, opts)
          return miniAiTreesitter(ai_type, _, opts, query_list)
        end
      end

      require('mini.ai').setup {
        custom_textobjects = {
          s = miniAiTreeWrapper { '@function', '@class', '@conditional', '@block', '@loop' }, -- Functions and classes
        },
      }
    end,
  },
}
