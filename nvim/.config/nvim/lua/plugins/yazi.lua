-- Yazi: Terminal File Manager
-- Used as replacement for netrw or things like neo-tree
-- Why? Because I also use it in the terminal outside of nvim
-- and it's nice to get an overview of the project or look for
-- files for which you can't remember the name.
-- (If you do know the name of the file, opening with a picker
-- is a lot faster of course)
vim.pack.add({
  "https://github.com/mikavilpas/yazi.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
})

require("yazi").setup()

-- Set custom keymap
vim.keymap.set("n", "<leader>E", "<cmd>Yazi cwd<cr>", { desc = "Open Yazi at cwd" })
vim.keymap.set("n", "<leader>e", "<cmd>Yazi<cr>", { desc = "Open Yazi at current file" })
