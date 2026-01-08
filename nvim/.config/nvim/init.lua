require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lsp")

-- require("plugins")

-- In your main init.lua, after vim.pack.add calls
local plugins_dir = vim.fn.stdpath("config") .. "/lua/plugins"
for _, file in ipairs(vim.fn.glob(plugins_dir .. "/*.lua", true, true)) do
	local name = file:match("([^/]+)%.lua$")
	if name ~= "init" then -- Skip the init.lua if it exists
		require("plugins." .. name)
	end
end
