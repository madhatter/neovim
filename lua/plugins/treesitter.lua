return {
	{
    "nvim-treesitter/nvim-treesitter",
    config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
                          "c",
                          "lua",
                          "vim",
                          "vimdoc",
                          "query",
                          "ruby",
                          "python",
                          "go",
                          "terraform",
                          "yaml",
                          "regex",
                          "kotlin",
        },

        auto_install = true,

        highlight = {
          enable = true,
        },
        build = ":TSUpdate",
      })
    end,
  },
}
