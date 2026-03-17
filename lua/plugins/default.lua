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
					-- Ensure fd and rg don't colorize output, follow symlinks, and exclude .git and node_modules directories
					fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude node_modules",
					rg_opts = "--color=never --files --hidden --follow --glob '!.git/*' --glob '!node_modules/*'",
				},
				grep = {
					-- Ensure live grep doesn't truncate long lines and that it shows line numbers and file names
					rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --follow -e",
				},
				previewers = {
					builtin = {
						extensions = {
							["parquet"] = {
								"sh",
								"-c",
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
	--- SpotifyUI
	{
		"AaravB23/spotui-nvim",
		config = function()
			require("spotui").setup({
				position = "bottom-left",
				poll_interval = 1000,
				window = {
					width = 30,
					expanded_height = 16,
					compact_height = 8,
					expand_duration = 4500,
				},
			})
		end,
	},
}
