return {
  {
    -- Neo-tree: File tree
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
      { '<leader>e', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    },
    opts = {
      default_component_configs = {
        name = {
          trailing_slash = false,
          use_git_status_colors = false,
        },
      },
      filesystem = {
        window = {
          position = 'float',
          mappings = {
            ['|'] = 'close_window',
          },
        },
      },
    },
  },
}
