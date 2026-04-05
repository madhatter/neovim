-- Disable built-in treesitter highlighter for markdown (compatibility with obsidian.nvim)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(args)
    vim.treesitter.stop(args.buf)
  end,
})

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

-- Hide winbar (dropbar) in terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.wo.winbar = ""
    end,
})

-- Use yaml.ansible for yaml files in ansible directory
vim.filetype.add({
  pattern = {
    [".*/ansible/.*/*%.ya?ml"] = "yaml.ansible",
  },
})

-- Kill kotlin-lsp proxy on exit (pre-alpha bug: proxy doesn't clean up on shutdown)
vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        vim.fn.jobstart("pkill -f kotlin-lsp", { detach = true })
        vim.fn.delete(vim.fn.expand("~/Library/Caches/kotlin-lsp-proxy"), "rf")
    end,
})
