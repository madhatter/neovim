return {
    {
        "Bekaboo/dropbar.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("dropbar").setup({
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
            vim.api.nvim_set_hl(0, "DropBarKindFile",     { bg = p.base01, fg = p.fg })
            vim.api.nvim_set_hl(0, "DropBarKindFunction", { bg = p.base01, fg = p.yellow })
            vim.api.nvim_set_hl(0, "DropBarKindMethod",   { bg = p.base01, fg = p.yellow })
            vim.api.nvim_set_hl(0, "DropBarKindClass",    { bg = p.base01, fg = p.yellow })
            vim.api.nvim_set_hl(0, "DropBarKindModule",   { bg = p.base01, fg = p.orange })
            vim.api.nvim_set_hl(0, "DropBarKindStruct",   { bg = p.base01, fg = p.yellow })
        end,
    },
}
