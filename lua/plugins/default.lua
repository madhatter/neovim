return {
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
					enable = true,
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
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},

	-- Development --
	"lewis6991/gitsigns.nvim",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/nvim-cmp",
	"neovim/nvim-lspconfig",
	"onsails/lspkind-nvim",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"L3MON4D3/LuaSnip",
}
