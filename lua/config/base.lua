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

-- don't show modes
opt.showmode = false

-- about searching
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- folding
opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

opt.tags="tags;/"

-- set conceallevel for obsidian plugin
-- each block of concealed text is replaced with one character
opt.conceallevel = 1

opt.termguicolors = true

-- change the colorscheme here
vim.cmd("colorscheme kanagawa-dragon")

opt.clipboard="unnamedplus"
