return {
  {
    -- Snacks: Collection of small plugins for Neovim from Folke
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true }, -- Open big files with less lag
      picker = { enabled = true },
      animate = { enabled = false },
      bufdelete = { enabled = false },
      dashboard = { enabled = false },
      debug = { enabled = false },
      dim = { enabled = false },
      explorer = { enabled = true },
      git = { enabled = false },
      gitbrowse = { enabled = false },
      indent = { enabled = true, chunk = { enabled = true }, animate = { enabled = false } },
      input = { enabled = false },
      layout = { enabled = false },
      lazygit = { enabled = true },
      notifier = { enabled = false },
      notify = { enabled = false },
      profiler = { enabled = false },
      quickfile = { enabled = false },
      rename = { enabled = false },
      scope = { enabled = false },
      scratch = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      terminal = { enabled = true },
      toggle = { enabled = false },
      util = { enabled = false },
      win = { enabled = false },
      words = { enabled = false },
      zen = { enabled = false },
    },
    keys = (function()
      -- Helper function to make Snacks keymap
      local function snacks_fn(mod, fn, desc)
        return {
          mod,
          function()
            require('snacks')[fn]()
          end,
          desc = desc,
        }
      end

      -- Helper function for Snacks.picker keymaps
      local function picker_fn(mod, fn, desc, opts)
        return {
          mod,
          function()
            require('snacks').picker[fn](opts or {})
          end,
          desc = desc,
        }
      end

      -- Actual table with keymaps

      return {
        picker_fn('<leader>e', 'explorer', 'Picker Explorer', {
          layout = { preset = 'vscode' },
          sources = {
            explorer = {
              auto_close = true,
            },
          },
        }),
        snacks_fn('<leader>gg', 'lazygit', 'Lazygit'),
        picker_fn('<D-p>', 'smart', 'Smart Find Files', {
          multi = { 'files' },
          layout = { preset = 'vscode' },
          formatters = { file = { filename_first = true } },
        }),
        picker_fn('<leader>fg', 'git_files', 'Find Git Files'),
        picker_fn('<leader>gb', 'git_branches', 'Git Branches'),
        picker_fn('<leader>gl', 'git_log', 'Git Log'),
        picker_fn('<leader>gL', 'git_log_line', 'Git Log Line'),
        picker_fn('<leader>gs', 'git_status', 'Git Status'),
        picker_fn('<leader>gS', 'git_stash', 'Git Stash'),
        picker_fn('<leader>gd', 'git_diff', 'Git Diff (Hunks)'),
        picker_fn('<leader>gf', 'git_log_file', 'Git Log File'),
      }
    end)(),
  },
}
