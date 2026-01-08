-- grug-far.nvim (search and replace) plugin configuration
vim.pack.add({
  "https://github.com/MagicDuck/grug-far.nvim",
})

require("grug-far").setup({
  headerMaxWidth = 80,
  keymaps = {
    -- Also allow tab and shift-tab in insert mode to move between inputs
    nextInput = { n = '<tab>', i = '<tab>' },
    prevInput = { n = '<s-tab>', i = '<s-tab>' },
  },
})

vim.keymap.set({ "n", "v", "x" }, "<C-S-f>", function()
  local grug = require("grug-far")
  local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
  grug.open({
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= "" and "*." .. ext or nil,
    },
  })
end, { desc = "Search and Replace" })
