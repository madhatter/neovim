-- TreeSitter highlight overrides to match NvChad's gruvbox look.
-- Shifts keywords and types from purple (base0E) to yellow (base0A),
-- which gives the characteristic warm, 70s feel of the NvChad theme.

local yellow = "#fabd2f"

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
