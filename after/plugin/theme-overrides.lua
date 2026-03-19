-- TreeSitter highlight overrides to match NvChad's gruvbox look.
-- Shifts keywords and types from purple (base0E) to yellow (base0A),
-- which gives the characteristic warm, 70s feel of the NvChad theme.

local yellow = "#fabd2f"
local orange = "#fe8019"
local fg     = "#d5c4a1"
local purple = "#d3869b"

-- Keywords: yellow instead of purple
vim.api.nvim_set_hl(0, "@keyword",          { fg = yellow })
vim.api.nvim_set_hl(0, "@keyword.function", { fg = yellow })
vim.api.nvim_set_hl(0, "@keyword.return",   { fg = yellow })
vim.api.nvim_set_hl(0, "@keyword.operator", { fg = yellow })
vim.api.nvim_set_hl(0, "@keyword.import",   { fg = yellow })
vim.api.nvim_set_hl(0, "@conditional",      { fg = yellow })
vim.api.nvim_set_hl(0, "@repeat",           { fg = yellow })

-- Types: yellow
vim.api.nvim_set_hl(0, "@type",         { fg = yellow })
vim.api.nvim_set_hl(0, "@type.builtin", { fg = yellow })

-- Properties and fields: yellow
vim.api.nvim_set_hl(0, "@variable.member", { fg = yellow })
vim.api.nvim_set_hl(0, "@property",        { fg = yellow })

-- Variables: neutral text instead of red (base16 default)
vim.api.nvim_set_hl(0, "@variable",           { fg = fg })
vim.api.nvim_set_hl(0, "@variable.parameter", { fg = purple })

-- Storage keywords (let, const, var): orange instead of red
vim.api.nvim_set_hl(0, "@keyword.storage",  { fg = orange })
vim.api.nvim_set_hl(0, "@storageclass",     { fg = orange })

-- Builtin variables (self, this): orange
vim.api.nvim_set_hl(0, "@variable.builtin", { fg = orange })

-- Strings: muted yellow-green instead of neon yellow-green
-- vim.api.nvim_set_hl(0, "@string", { fg = "#98971a" })

-- LSP semantic token overrides: mirror the TreeSitter assignments above.
-- LSP tokens run after TreeSitter and would otherwise silently override them.
vim.api.nvim_set_hl(0, "@lsp.type.variable",  { fg = fg })
vim.api.nvim_set_hl(0, "@lsp.type.parameter", { fg = purple })
vim.api.nvim_set_hl(0, "@lsp.type.property",  { fg = yellow })
vim.api.nvim_set_hl(0, "@lsp.type.type",      { fg = yellow })
vim.api.nvim_set_hl(0, "@lsp.type.class",     { fg = yellow })
vim.api.nvim_set_hl(0, "@lsp.type.interface", { fg = yellow })
vim.api.nvim_set_hl(0, "@lsp.type.enum",      { fg = yellow })
