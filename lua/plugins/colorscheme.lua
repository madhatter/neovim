return {
	"rebelot/kanagawa.nvim",
  -- welcome screen
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
    end
  },
}
