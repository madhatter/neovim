-- Set textwidth for markdown files
vim.api.nvim_create_autocmd(
  {
    "BufNewFile",
    "BufRead",
  },
  {
    pattern = "*.mdown,*.md",
    callback = function()
      vim.opt.textwidth = 80
    end
  }
)

-- Format augroup/autocomd
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

-- Use yaml.ansible for yaml files in ansible directory
vim.filetype.add({
  pattern = {
    [".*/ansible/.*/*%.ya?ml"] = "yaml.ansible",
  },
})
