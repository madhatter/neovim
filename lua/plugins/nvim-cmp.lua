return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",  -- Load when entering insert mode
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind-nvim",
      "zbirenbaum/copilot-cmp",
    },
  },
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "neovim/nvim-lspconfig",
  "onsails/lspkind-nvim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  {
      "zbirenbaum/copilot-cmp",
      config = function()
          require("copilot_cmp").setup()
      end,
  },
}
