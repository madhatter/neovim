return {
  {
    'ray-x/navigator.lua',
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("navigator").setup({
        icons = {
          -- turn off all the icons, this is a terminal application
          icons = false,
        },
      })
    end,
    event = { 'VeryLazy' },
  }
}
