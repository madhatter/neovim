return {
	-- Productivity --
	"nvim-lualine/lualine.nvim",
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({
				files = {
					actions = {
						["ctrl-g"] = require("fzf-lua").actions.toggle_ignore,
					},
				},
			})
			require("fzf-lua").register_ui_select()
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	"eandrju/cellular-automaton.nvim",
	{ "wakatime/vim-wakatime", lazy = false },
}
