-- TreeSitter highlight overrides to match NvChad's gruvbox look.
-- Shifts keywords and types from purple (base0E) to yellow (base0A),
-- which gives the characteristic warm, 70s feel of the NvChad theme.

local p      = require("config.palette")
local yellow = p.yellow
local orange = p.orange
local fg     = p.fg
local purple = p.purple
local subtle = p.base02 -- used for borders and separators

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

-- UI chrome: subtle borders, separators and popups to match the muted Reddit look
vim.api.nvim_set_hl(0, "SignColumn",    { bg = p.base01 })
vim.api.nvim_set_hl(0, "LineNr",       { bg = p.base01, fg = p.base03 })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = p.base01, fg = p.base04 })
vim.api.nvim_set_hl(0, "FloatBorder",   { fg = subtle, bg = p.base00 })
vim.api.nvim_set_hl(0, "WinSeparator",  { fg = subtle })
vim.api.nvim_set_hl(0, "CursorLine",    { bg = p.base01 })
vim.api.nvim_set_hl(0, "NormalFloat",    { bg = p.base00, fg = p.fg })
vim.api.nvim_set_hl(0, "Pmenu",         { bg = p.base00, fg = p.fg })
vim.api.nvim_set_hl(0, "PmenuSel",      { bg = p.base02, fg = p.fg, bold = true })
vim.api.nvim_set_hl(0, "PmenuKind",              { bg = p.base00 })
vim.api.nvim_set_hl(0, "PmenuKindSel",           { bg = p.base02 })
vim.api.nvim_set_hl(0, "PmenuExtra",             { bg = p.base00, fg = p.base03 })
vim.api.nvim_set_hl(0, "PmenuExtraSel",          { bg = p.base02 })
vim.api.nvim_set_hl(0, "CmpItemAbbr",            { bg = "NONE", fg = p.fg })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch",       { bg = "NONE", fg = p.yellow, bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy",  { bg = "NONE", fg = p.orange })
vim.api.nvim_set_hl(0, "CmpItemKind",            { bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemMenu",            { bg = "NONE", fg = p.base03 })

-- LSP semantic token overrides: mirror the TreeSitter assignments above.
-- LSP tokens run after TreeSitter and would otherwise silently override them.
vim.api.nvim_set_hl(0, "@lsp.type.variable",  { fg = fg })
vim.api.nvim_set_hl(0, "@lsp.type.parameter", { fg = purple })
vim.api.nvim_set_hl(0, "@lsp.type.property",  { fg = yellow })
vim.api.nvim_set_hl(0, "@lsp.type.type",      { fg = yellow })
vim.api.nvim_set_hl(0, "@lsp.type.class",     { fg = yellow })
vim.api.nvim_set_hl(0, "@lsp.type.interface", { fg = yellow })
vim.api.nvim_set_hl(0, "@lsp.type.enum",      { fg = yellow })

-- Winbar (breadcrumbs via dropbar.nvim)
vim.api.nvim_set_hl(0, "WinBar",      { bg = p.base01, fg = p.fg })
vim.api.nvim_set_hl(0, "WinBarNC",    { bg = p.base01, fg = p.base03 })

-- Warning messages: yellow instead of red to avoid error association
vim.api.nvim_set_hl(0, "WarningMsg",  { fg = p.yellow })
