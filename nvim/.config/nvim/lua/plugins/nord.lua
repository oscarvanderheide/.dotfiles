-- Nord colortheme with some modifications
vim.pack.add({
	{
		src = "https://github.com/gbprod/nord.nvim",
		version = vim.version.range("^1"),
	},
})

-- Set the colorscheme to Nord
vim.cmd.colorscheme("nord")

-- Change background color to something darker, same as wezterm background
vim.cmd("highlight Normal guibg=#1e2128")

-- Emulate "transparent = true"
local transparent = true
if transparent then
	local groups = {
		"Normal",
		"NormalNC",
		"NormalFloat",
		"SignColumn",
		"MsgArea",
		"TelescopeNormal",
		"TelescopeBorder",
		"FloatBorder",
		"Pmenu",
		"WinSeparator",
		"StatusLine",
		"StatusLineNC",
	}
	for _, group in ipairs(groups) do
		vim.api.nvim_set_hl(0, group, { bg = "none" })
	end
end

-- Set custom colors for search and incsearch
vim.api.nvim_set_hl(0, "Search", { bg = "#434C5E", fg = "white" })
vim.api.nvim_set_hl(0, "IncSearch", { bg = "#777700", fg = "white" })

-- Set border color between splits
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#434C5E", bg = "NONE" })
