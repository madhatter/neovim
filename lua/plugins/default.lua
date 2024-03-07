return {
  -- Productivity --
  "nvim-lualine/lualine.nvim",
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  "eandrju/cellular-automaton.nvim",
}
