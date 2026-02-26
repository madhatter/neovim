local opt = vim.opt

vim.g.mapleader = ";"

vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
if vim.bo.modifiable then
  opt.fileencoding = "utf-8"
end

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
opt.autoread = true

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

-- set refresh times to prevent lag on external display
vim.opt.updatetime = 100 -- faster completion, might help for lualine ui refresh
vim.opt.timeoutlen = 300 -- waiting time for a mapped sequence to complete (in milliseconds)
vim.opt.ttimeoutlen = 10 -- waiting time for escape sequences to complete (in milliseconds)

-- experimental settings for an even better performance.
vim.opt.lazyredraw = false -- might be better on modern GPUs
vim.opt.synmaxcol = 240 -- faster syntax highlighting for long lines

-- set conceallevel for obsidian plugin
-- each block of concealed text is replaced with one character
opt.conceallevel = 1

-- change the colorscheme here
--vim.cmd("colorscheme kanagawa-dragon")

-- Show LSP loading progress
vim.lsp.handlers['$/progress'] = function(_, progress, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local client_name = client and client.name or "Unknown"
  local val = progress.value
  if val.kind then
    if val.kind == 'begin' then
      vim.notify('LSP [' .. client_name .. ']: ' .. (val.title or ''))
    elseif val.kind == 'report' then
      vim.notify('LSP [' .. client_name .. ']: ' .. (val.message or ''))
    elseif val.kind == 'end' then
      vim.notify('LSP [' .. client_name .. ']: ' .. (val.message or 'Completed'))
    end
  end
end

