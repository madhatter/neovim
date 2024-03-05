-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Themes --
  "rebelot/kanagawa.nvim",
  -- Productivity --
  "nvim-lualine/lualine.nvim",
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "ruby", "python", "go" },

            auto_install = true,

            highlight = {
                enable = true
            },
        })
        end,
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end
  },
  -- Development --
  "lewis6991/gitsigns.nvim",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/nvim-cmp",
  "neovim/nvim-lspconfig",
  "onsails/lspkind-nvim",
  "quangnguyen30192/cmp-nvim-ultisnips",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "L3MON4D3/LuaSnip",
})
