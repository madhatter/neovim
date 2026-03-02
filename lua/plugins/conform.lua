return {
	{
		"stevearc/conform.nvim",
		-- Lazy loading: when the command :ConformInfo is used
		cmd = { "ConformInfo" },
		-- Or when hitting the format keybinding
		keys = {
			{
				"<leader>F",
				function()
					require("conform").format({
						async = true,
						lsp_fallback = true,
					})
				end,
				mode = { "n", "v" },
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			formatters = {
				sqlfluff = {
					args = { "fix", "--FIX-EVEN-UNPARSABLE", "--dialect", "athena", "-" },
				},
			},
			formatters_by_ft = {
				-- Define which formatters to use for specific filetypes
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "black" },
				-- You can customize some of the format options for the filetype (:help conform.format)
				rust = { "rustfmt", lsp_format = "fallback" },
				-- Conform will run the first available formatter
				javascript = { "prettierd", "prettier", stop_after_first = true },
				kotlin = { "ktfmt" },
				go = { "gofmt" },
				terraform = { "terraform_fmt" },
				tf = { "terraform_fmt" },
				["terraform-vars"] = { "terraform_fmt" },
				sql = { "sqlfluff" },
				["yaml.ansible"] = { "yamlfmt" },
				-- Use the "*" filetype to run formatters on all files
				-- "trim_whitespace" removes trailing whitespace
				["*"] = { "trim_whitespace" },
			},
			default_format_opts = {
				lsp_fallback = true,
			},
			format_on_save = nil,
		},
	},
}
