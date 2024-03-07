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
