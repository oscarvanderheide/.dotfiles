-- Auto-session: Automatically reopen the files and windows you had open.
vim.pack.add({
  "https://github.com/rmagatti/auto-session",
})

local options = {
  suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
}

require("auto-session").setup(options)
