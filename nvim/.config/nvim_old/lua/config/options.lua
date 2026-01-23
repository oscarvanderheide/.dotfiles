-- -- Editor options
local opt = vim.opt

opt.number = true -- Line numbers
opt.relativenumber = true -- Relative line numbers
opt.cursorline = false -- Highlight current line
opt.wrap = false -- Don't wrap lines
opt.scrolloff = 16 -- Keep 10 lines above/below cursor
opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor

-- Indentation
opt.tabstop = 2 -- Tab width
opt.shiftwidth = 2 -- Indent width
opt.softtabstop = 2 -- Soft tab stop
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Smart auto-indenting
opt.autoindent = true -- Copy indent from current line

-- Search settings
opt.ignorecase = true -- Case insensitive search
opt.smartcase = true -- Case sensitive if uppercase in search
opt.hlsearch = false -- Don't highlight search results
opt.incsearch = true -- Show matches as you type

-- Visual settings
opt.termguicolors = true -- Enable 24-bit colors
opt.signcolumn = 'yes' -- Always show sign column
opt.showmatch = true -- Highlight matching brackets
opt.matchtime = 2 -- How long to show matching bracket
opt.cmdheight = 1 -- Command line height
opt.showmode = false -- Don't show mode in command line
opt.pumheight = 10 -- Popup menu height
opt.pumblend = 10 -- Popup menu transparency
opt.winblend = 0 -- Floating window transparency
opt.completeopt = 'menu,menuone,noselect'
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.concealcursor = '' -- Don't hide cursor line markup
opt.synmaxcol = 300 -- Syntax highlighting limit
opt.ruler = false -- Disable the default ruler
opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
opt.winminwidth = 5 -- Minimum window width

-- File handling
opt.backup = false -- Don't create backup files
opt.writebackup = false -- Don't create backup before writing
opt.swapfile = false -- Don't create swap files
opt.undofile = true -- Persistent undo
opt.undolevels = 10000
opt.undodir = vim.fn.expand '~/.vim/undodir' -- Undo directory
opt.updatetime = 300 -- Faster completion
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
opt.ttimeoutlen = 0 -- Key code timeout
opt.autoread = true -- Auto reload files changed outside vim
opt.autowrite = true -- Auto save

-- Behavior settings
opt.hidden = true -- Allow hidden buffers
opt.errorbells = false -- No error bells
opt.backspace = 'indent,eol,start' -- Better backspace behavior
opt.autochdir = false -- Don't auto change directory
opt.iskeyword:append '-' -- Treat dash as part of word
opt.path:append '**' -- include subdirectories in search
opt.selection = 'exclusive' -- Selection behavior
opt.mouse = 'a' -- Enable mouse support
opt.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus' -- Sync with system clipboard
opt.modifiable = true -- Allow buffer modifications
opt.encoding = 'UTF-8' -- Set encoding

-- Folding settings
opt.smoothscroll = true
vim.wo.foldmethod = 'expr'
opt.foldlevel = 99 -- Start with all folds open
opt.formatoptions = 'jcroqlnt' -- tcqj
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'

-- Split behavior
opt.splitbelow = true -- Horizontal splits go below
opt.splitright = true -- Vertical splits go right
opt.splitkeep = 'screen'

-- Command-line completion
opt.wildmenu = true
opt.wildmode = 'longest:full,full'
opt.wildignore:append { '*.o', '*.obj', '*.pyc', '*.class', '*.jar' }

-- Better diff options
opt.diffopt:append 'linematch:60'

-- Performance improvements
opt.redrawtime = 10000
opt.maxmempattern = 20000

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand '~/.vim/undodir'
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, 'p')
end

vim.g.autoformat = true
vim.g.trouble_lualine = true

opt.fillchars = {
  foldopen = ' ',
  foldclose = ' ',
  fold = ' ',
  foldsep = ' ',
  diff = '/',
  eob = ' ',
}

opt.jumpoptions = 'view'
opt.laststatus = 3 -- global statusline
opt.list = false
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true -- Show some invisible characters (tabs...
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append { W = true, I = true, c = true, C = true }

vim.o.laststatus = 0 -- Disable status

-- vim.g.markdown_recommended_style = 0

-- vim.filetype.add {
--   extension = {
--     env = 'dotenv',
--   },
--   filename = {
--     ['.env'] = 'dotenv',
--     ['env'] = 'dotenv',
--   },
--   pattern = {
--     ['[jt]sconfig.*.json'] = 'jsonc',
--     ['%.env%.[%w_.-]+'] = 'dotenv',
--   },
-- }
-- vim.g.mapleader = ' ' -- Set leader key to space
-- vim.g.maplocalleader = ',' -- Set local leader key to comma
-- vim.g.have_nerd_font = true -- Requires Nerd Font to be installed
--
-- vim.opt.number = true -- Show line numbers
-- vim.opt.relativenumber = true -- Show relative line numbers
-- vim.opt.mouse = 'a' -- Enable mouse in all modes
-- vim.opt.wrap = false -- No line wrapping
-- vim.opt.expandtab = true -- Replace tab with spaces
-- vim.opt.showmode = true -- Don't show mode in status line
-- vim.opt.breakindent = true -- Indent wrapped lines
-- vim.opt.undofile = true -- Save undo history
-- vim.opt.ignorecase = true -- Case insensitive search
-- vim.opt.smartcase = true -- Case sensitive if pattern contains upper case
-- vim.opt.signcolumn = 'yes' -- Keep signcolumn on
-- vim.opt.updatetime = 100 -- Time before saving swap file changes
-- vim.opt.timeoutlen = 300 -- Time to wait for mapped key sequence
-- vim.opt.splitright = true -- Vertical splits open to the right
-- vim.opt.splitbelow = true -- Horizontal splits open below
-- vim.opt.inccommand = 'split' -- Preview substitutions live
-- vim.opt.incsearch = true -- Incremental search
-- vim.opt.cursorline = false -- Highlight current line
-- vim.opt.scrolloff = 16 -- Keep lines above and below the cursor
-- vim.opt.termguicolors = true -- Enable more colors
-- vim.opt.cmdheight = 1 -- Hide the command line
-- vim.opt.swapfile = false -- Disable swap files (I'll save myself)
-- vim.opt.clipboard = 'unnamedplus' -- Use the system clipboard
-- vim.opt.tabstop = 2
-- vim.opt.softtabstop = 2
-- vim.opt.shiftwidth = 2
-- vim.opt.smartindent = true
-- -- vim.opt.colorcolumn = '80,120'
-- vim.opt.textwidth = 80
-- vim.opt.wrapmargin = 0
-- vim.opt.linebreak = true
-- -- Disable gutter for now
-- vim.opt.signcolumn = 'no'
-- vim.opt.number = true
-- vim.opt.textwidth = 0
-- vim.opt.wrapmargin = 0
-- vim.opt.wrap = true
-- vim.opt.linebreak = true
-- vim.opt.columns = 80
-- vim.o.laststatus = 0
