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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "snacks_terminal",
  desc = "Disable TmuxNavigate and set keys for Gemini Input",
  callback = function(args)
    -- Remap TmuxNavigate keys to pass them through for this terminal buffer.
    -- This overrides the global mapping from vim-tmux-navigator.
    vim.keymap.set('t', '<C-h>', '<C-h>', { buffer = args.buf })
    vim.keymap.set('t', '<C-j>', '<C-j>', { buffer = args.buf })
    vim.keymap.set('t', '<C-k>', '<C-k>', { buffer = args.buf })
    vim.keymap.set('t', '<C-l>', '<C-l>', { buffer = args.buf })
  end,
})
