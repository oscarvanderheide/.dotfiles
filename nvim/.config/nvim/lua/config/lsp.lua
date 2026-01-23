-- LSP Configuration
-- Using vim.pack.add for Neovim 0.12's native package manager
-- Still using lspconfig (sane defaults) with mason (easy installation of LSP servers)
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" }, -- Core LSP configuration
	{ src = "https://github.com/mason-org/mason.nvim" }, -- LSP installer with UI
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" }, -- Bridge between mason and lspconfig
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" }, -- Auto-install LSP servers
	{ src = "https://github.com/folke/lazydev.nvim" }, -- Properly configures lua_ls for Neovim development
})

-- Initialize: mason (must be called before mason-lspconfig)
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"bashls", -- Bash/shell scripts
		"html", -- HTML
		"jsonls", -- JSON
		"julials", -- Julia
		"lua_ls", -- Lua (Neovim config)
		-- "basedpyright", -- Python type checking (fork of pyright with better inlay hints)
		"yamlls", -- YAML
		"ruff", -- Python linting/formatting
	},
})

-- Setup lazydev for better lua_ls configuration for Neovim
-- The default lua_ls settings cause vim global to be unrecognized
-- Some fixes cause issues with lua_ls loading times, so lazydev is preferred
require("lazydev").setup({
	library = {
		-- This ensures the "vim" global is recognized
		{ path = "luvit-meta/library", words = { "vim%.uv" } },
	},
})

-- Lua specific stuff
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
})

-- -- Julia specific stuff
-- First do:
-- 'julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")''
vim.lsp.config("julials", {
	cmd = {
		"julia",
		"--project=" .. "~/.julia/environments/nvim-lspconfig/",
		"--startup-file=no",
		"--history-file=no",
		"-e",
		[[
        using Pkg
        Pkg.instantiate()
        using LanguageServer
        depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
        project_path = let
            dirname(something(
                ## 1. Finds an explicitly set project (JULIA_PROJECT)
                Base.load_path_expand((
                    p = get(ENV, "JULIA_PROJECT", nothing);
                        p === nothing ? nothing : isempty(p) ? nothing : p
                    )),
                        ## 2. Look for a Project.toml file in the current working directory,
                        ##    or parent directories, with $HOME as an upper boundary
                        Base.current_project(),
                        ## 3. First entry in the load path
                        get(Base.load_path(), 1, nothing),
                        ## 4. Fallback to default global environment,
                        ##    this is more or less unreachable
                    Base.load_path_expand("@v#.#"),
                ))
            end
        @info "Running language server" VERSION pwd() project_path depot_path
        server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
        server.runlinter = true
        run(server)
    ]],
	},
	filetypes = { "julia" },
	root_markers = { "Project.toml", "JuliaProject.toml" },
	settings = {},
})

-- If at some point I want to switch to jetls (check docs online as well):
-- vim.lsp.config("jetls", {
-- 	cmd = {
-- 		"jetls",
-- 		"--threads=auto",
-- 		"--",
-- 	},
-- 	filetypes = { "julia" },
-- })
--
-- vim.lsp.enable("jetls")
