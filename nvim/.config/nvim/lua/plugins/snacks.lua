return {
  {
    -- Snacks: Collection of small plugins for Neovim from Folke
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true }, -- Open big files with less lag
      picker = { enabled = false },
      animate = { enabled = false },
      bufdelete = { enabled = false },
      dashboard = { enabled = false },
      debug = { enabled = false },
      dim = { enabled = false },
      explorer = { enabled = false },
      git = { enabled = false },
      gitbrowse = { enabled = false },
      indent = { enabled = false },
      input = { enabled = false },
      layout = { enabled = false },
      lazygit = { enabled = false },
      notifier = { enabled = false },
      notify = { enabled = false },
      profiler = { enabled = false },
      quickfile = { enabled = false },
      rename = { enabled = false },
      scope = { enabled = false },
      scratch = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      terminal = { enabled = false },
      toggle = { enabled = false },
      util = { enabled = false },
      win = { enabled = false },
      words = { enabled = false },
      zen = { enabled = false },
    },
    -- keys = {
    --   -- git
    --   {
    --     '<leader>gb',
    --     function()
    --       require('snacks').picker.git_branches()
    --     end,
    --     desc = 'Git Branches',
    --   },
    --   {
    --     '<leader>gl',
    --     function()
    --       require('snacks').picker.git_log()
    --     end,
    --     desc = 'Git Log',
    --   },
    --   {
    --     '<leader>gL',
    --     function()
    --       require('snacks').picker.git_log_line()
    --     end,
    --     desc = 'Git Log Line',
    --   },
    --   {
    --     '<leader>gs',
    --     function()
    --       require('snacks').picker.git_status()
    --     end,
    --     desc = 'Git Status',
    --   },
    --   {
    --     '<leader>gS',
    --     function()
    --       require('snacks').picker.git_stash()
    --     end,
    --     desc = 'Git Stash',
    --   },
    --   {
    --     '<leader>gd',
    --     function()
    --       require('snacks').picker.git_diff()
    --     end,
    --     desc = 'Git Diff (Hunks)',
    --   },
    --   {
    --     '<leader>gf',
    --     function()
    --       require('snacks').picker.git_log_file()
    --     end,
    --     desc = 'Git Log File',
    --   },
    -- },
  },
}
