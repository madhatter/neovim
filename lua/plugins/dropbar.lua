return {
    {
        "Bekaboo/dropbar.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("dropbar").setup({
                bar = {
                    enable = function(buf, win, _)
                        return vim.api.nvim_buf_get_option(buf, "buftype") ~= "terminal"
                            and vim.api.nvim_win_get_config(win).relative == ""
                    end,
                },
                icons = {
                    ui = {
                        bar = {
                            separator = " › ",
                        },
                    },
                },
            })

            local p = require("config.palette")
            vim.api.nvim_set_hl(0, "DropBarIconUISeparator", { bg = p.base01, fg = p.cyan })
            vim.api.nvim_set_hl(0, "DropBarKindDir",      { fg = p.base03 })
            vim.api.nvim_set_hl(0, "DropBarKindFile",     { fg = p.fg })
            vim.api.nvim_set_hl(0, "DropBarKindFunction", { fg = p.yellow })
            vim.api.nvim_set_hl(0, "DropBarKindMethod",   { fg = p.yellow })
            vim.api.nvim_set_hl(0, "DropBarKindClass",    { fg = p.yellow })
            vim.api.nvim_set_hl(0, "DropBarKindModule",   { fg = p.orange })
            vim.api.nvim_set_hl(0, "DropBarKindStruct",   { fg = p.yellow })

            vim.api.nvim_set_hl(0, "DropBarMenuHoverEntry",     { bg = p.base02, fg = p.fg })
            vim.api.nvim_set_hl(0, "DropBarMenuHoverIcon",      { bg = p.base02 })
            vim.api.nvim_set_hl(0, "DropBarMenuCurrentContext", { bg = p.base02 })
        end,
    },
}
