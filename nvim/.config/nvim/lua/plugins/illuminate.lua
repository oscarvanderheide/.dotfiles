vim.pack.add({ "https://github.com/RRethy/vim-illuminate" })

require('illuminate').configure({
  delay = 1,
})

-- Change the highlight style: needs to be an autocommand otherwise the colorscheme may override it
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = '#333333' })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = '#333333' })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = '#333333' })
  end
})
