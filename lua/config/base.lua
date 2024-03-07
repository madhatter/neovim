local opt = vim.opt

vim.g.python3_host_prog = "/opt/homebrew/bin/python3"

vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.relativenumber = true
opt.number = true -- show the line number of the current line

opt.title = true
opt.autoindent = true
opt.smartindent = true
opt.backup = true
opt.backupdir = os.getenv("HOME") .. "/.backup"
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.undo"
opt.swapfile = false
opt.showcmd = true
opt.cmdheight = 1
opt.laststatus = 2
opt.expandtab = true
opt.scrolloff = 10
opt.backupskip = { "/tmp/*", "/private/tmp/*" }
opt.inccommand = "split"
opt.virtualedit = "block" -- use blocks even thouth the lines won't fit

opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
opt.smarttab = true
opt.breakindent = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.showmatch = true
opt.wrap = false -- No Wrap lines
opt.backspace = { "start", "eol", "indent" }
opt.path:append({ "**" }) -- Finding files - Search down into subfolders
opt.wildignore:append({ "*/node_modules/*" })
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.splitkeep = "cursor"
opt.mouse = ""
opt.modifiable = true

-- make the history longer
opt.history=500

-- about searching
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- folding
-- fold on syntax
opt.foldmethod = "indent"
--vim.opt.foldmethod = "expr"
--vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 5
opt.foldcolumn = "auto:5"
opt.foldlevelstart = 5
opt.foldnestmax = 5

opt.tags="tags;/"

-- change the colorscheme here
vim.cmd("colorscheme kanagawa-dragon")
