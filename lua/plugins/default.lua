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
				winopts = {
					preview = {
						wrap = "nowrap",
					},
				},
				files = {
					actions = {
						["ctrl-g"] = require("fzf-lua").actions.toggle_ignore,
					},
				},
				previewers = {
					builtin = {
						extensions = {
							["parquet"] = {
								"sh", "-c",
								[[duckdb -noheader -column -c "SELECT * FROM read_parquet('$1') LIMIT 100;" | cut -c1-120]],
								"sh",
							},
						},
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
