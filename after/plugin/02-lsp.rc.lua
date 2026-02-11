-- ============================================================================
-- after/plugin/lsp.rc.lua
-- ============================================================================
-- LSP keybindings, diagnostics, and server configurations
-- ============================================================================

local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- ============================================================================
-- DIAGNOSTIC CONFIGURATION
-- ============================================================================

vim.diagnostic.config({
	float = {
		border = "rounded",
		style = "minimal",
		header = "",
		prefix = "",
		winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,NormalFloat:Pmenu",
	},
})

-- ============================================================================
-- LSP KEYMAPS (on attach)
-- ============================================================================

-- Helper function for styled float windows
local function open_styled_float(float_func)
	return function()
		float_func({
			border = "rounded",
			winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,NormalFloat:Pmenu",
		})
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }

		-- Navigation
		vim.keymap.set(
			"n",
			"gd",
			require("fzf-lua").lsp_definitions,
			vim.tbl_extend("force", opts, { desc = "Definition" })
		)
		vim.keymap.set(
			"n",
			"gD",
			require("fzf-lua").lsp_declarations,
			vim.tbl_extend("force", opts, { desc = "Declaration" })
		)
		vim.keymap.set(
			"n",
			"gi",
			require("fzf-lua").lsp_implementations,
			vim.tbl_extend("force", opts, { desc = "Implementation" })
		)
		vim.keymap.set("n", "gr", require("fzf-lua").lsp_references, opts)
		vim.keymap.set(
			"n",
			"gy",
			require("fzf-lua").lsp_typedefs,
			vim.tbl_extend("force", opts, { desc = "Type definition" })
		)

		-- Documentation
		vim.keymap.set("n", "K", open_styled_float(vim.lsp.buf.hover), opts)
		vim.keymap.set("n", "<space>e", open_styled_float(vim.lsp.buf.hover), opts)
		vim.keymap.set(
			"n",
			"<leader>ds",
			require("fzf-lua").lsp_document_symbols,
			vim.tbl_extend("force", opts, { desc = "Document symbols" })
		)
		vim.keymap.set(
			"n",
			"<leader>ws",
			require("fzf-lua").lsp_workspace_symbols,
			vim.tbl_extend("force", opts, { desc = "Workspace symbols" })
		)

		-- Actions
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>ca", function()
			require("fzf-lua").lsp_code_actions()
		end, vim.tbl_extend("force", opts, { desc = "Code actions" }))

		-- Diagnostics
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		vim.keymap.set(
			"n",
			"<leader>dd",
			require("fzf-lua").diagnostics_document,
			vim.tbl_extend("force", opts, { desc = "Diagnostics (buffer)" })
		)
		vim.keymap.set(
			"n",
			"<leader>dD",
			require("fzf-lua").diagnostics_workspace,
			vim.tbl_extend("force", opts, { desc = "Diagnostics (workspace)" })
		)
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
	end,
})

-- ============================================================================
-- LSP SERVER CONFIGURATIONS
-- ============================================================================

local capabilities = cmp_nvim_lsp.default_capabilities()

-- Reusable LSP settings table
local lsp_servers = {
	gopls = {
		settings = {
			gopls = {
				analyses = {
					assign = true,
					atomic = true,
					bools = true,
					composites = true,
					copylocks = true,
					deepequalerrors = true,
					embed = true,
					errorsas = true,
					httpresponse = true,
					ifaceassert = true,
					loopclosure = true,
					lostcancel = true,
					nilfunc = true,
					nilness = true,
					nonewvars = true,
					printf = true,
					shadow = true,
					shift = true,
					simplifycompositelit = true,
					simplifyrange = true,
					simplifyslice = true,
					sortslice = true,
					stdmethods = true,
					stringintconv = true,
					structtag = true,
					testinggoroutine = true,
					tests = true,
					timeformat = true,
					unmarshal = true,
					unreachable = true,
					unsafeptr = true,
					unusedparams = true,
					unusedresult = true,
					unusedvariable = true,
					unusedwrite = true,
					useany = true,
				},
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
				hoverKind = "FullDocumentation",
				linkTarget = "pkg.go.dev",
				usePlaceholders = true,
				vulncheck = "Imports",
			},
		},
	},
	kotlin_language_server = {
		settings = {
			compiler = {
				jvm = {
					target = "20",
				},
			},
		},
	},
	pyright = {
		settings = {},
	},
	tsserver = {
		settings = {},
	},
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
			},
		},
	},
	yamlls = {
		settings = {
			yaml = {
				format = { enable = true },
				hover = true,
				completion = true,
				customTags = {
					"!fn",
					"!And",
					"!If",
					"!Not",
					"!Equals",
					"!Or",
					"!FindInMap sequence",
					"!Base64",
					"!Cidr",
					"!Ref",
					"!Ref Scalar",
					"!Sub",
					"!GetAtt",
					"!GetAZs",
					"!ImportValue",
					"!Select",
					"!Split",
					"!Join sequence",
				},
			},
		},
	},
	clangd = {
		settings = {},
	},
}

-- Configure and enable all LSP servers
for server, config in pairs(lsp_servers) do
	vim.lsp.config(server, vim.tbl_extend("force", {
		capabilities = capabilities,
	}, config))
	vim.lsp.enable(server)
end
