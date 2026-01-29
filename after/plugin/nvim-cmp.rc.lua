-- Safe requires for plugins
local cmp_setup, cmp = pcall(require, "cmp")
if not cmp_setup then
	return
end

local lspkind_setup, lspkind = pcall(require, "lspkind")
if not lspkind_setup then
	return
end

local cmp_nvim_lsp_setup, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_setup then
	return
end

local mason_setup, mason = pcall(require, "mason")
if not mason_setup then
	return
end

local mason_lspc_setup, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspc_setup then
	return
end

-- Use new lspconfig API if available
local lspconfig = nil
if vim.lsp.config ~= nil then
	lspconfig = vim.lsp.config
else
	-- fallback for old versions
	local ok, lc = pcall(require, "lspconfig")
	if not ok then
		return
	end
	lspconfig = lc
end

cmp.setup({
	preselect = cmp.PreselectMode.None,
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		--completion = cmp.config.window.bordered(),
		completion = {
			border = "rounded",
			--winhighlight = "Normal:MyPmenu,FloatBorder:MyFloatBorder,CursorLine:MyPmenuSel,Search:None",
			winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
			col_offset = -3, -- Optional: Rückt das Icon etwas nach links für mehr Platz
			side_padding = 0,
		},
		--documentation = cmp.config.window.bordered(),
		documentation = {
			border = "rounded",
			--winhighlight = "Normal:MyPmenu,FloatBorder:MyFloatBorder,CursorLine:MyPmenuSel,Search:None",
			winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
		},
	},
	mapping = cmp.mapping.preset.insert({
		-- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
		-- ['<C-f>'] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = false,
		}),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
			symbol_map = { Copilot = "" },
			before = function(entry, vim_item)
				return vim_item
			end,
		}),
	},
	sources = cmp.config.sources({
		{ name = "copilot", group_index = 2 },
		{ name = "nvim_lsp", group_index = 2 },
		{ name = "luasnip", group_index = 2 },
		{ name = "buffer", group_index = 2 },
	}),
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

local capabilities = cmp_nvim_lsp.default_capabilities()

-- Global LSP mappings
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- More LSP mappings
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		-- Goto definition (gd)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		-- Hover Documentation (K)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		-- Rename Symbol (leader+rn)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		-- Use of fzf-lua for references (instead of default) - gr
		vim.keymap.set("n", "gr", require("fzf-lua").lsp_references, opts)
		--vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		-- Code Actions (Für Ruff Fixes etc.) - <leader>ca
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		--vim.keymap.set({ "n", "v" }, "<space>.", vim.lsp.buf.code_action, opts)
	end,
})

-- function to enable/disable autocompletion mode of cmp
function SetAutoCmp(mode)
	if mode then
		cmp.setup({
			completion = {
				autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
			},
		})
	else
		cmp.setup({
			completion = {
				autocomplete = false,
			},
		})
	end
end
SetAutoCmp(true)

vim.cmd("command AutoCmpOn lua SetAutoCmp(true)")
vim.cmd("command AutoCmpOff lua SetAutoCmp(false)")

-- Mason general setup
mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- Mason ensure installation of LSPs
mason_lspconfig.setup({
	ensure_installed = { "gopls", "lua_ls", "pyright", "yamlls", "kotlin_language_server" },
	auto_install = true,
	automatic_enable = false,
})

-- Configure LSPs using new API if available
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = function(client, bufnr)
	-- (deine eigenen Mappings und andere Logik)
end

-- Go (gopls)
vim.lsp.config("gopls", {
	capabilities = capabilities,
	on_attach = on_attach,
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
				-- fieldalignment = true,
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
})
vim.lsp.enable("gopls")

-- Kotlin (kotlin_language_server)
vim.lsp.config("kotlin_language_server", {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		compiler = {
			jvm = {
				target = "20",
			},
		},
	},
})
vim.lsp.enable("kotlin_language_server")

-- Python (pyright)
vim.lsp.config("pyright", {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {},
})
vim.lsp.enable("pyright")

-- Typescript (tsserver, falls ts_ls)
vim.lsp.config("tsserver", {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {},
})
vim.lsp.enable("tsserver")

-- Lua (lua_ls)
vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
		},
	},
})
vim.lsp.enable("lua_ls")

-- YAML (yamlls)
vim.lsp.config("yamlls", {
	capabilities = capabilities,
	on_attach = on_attach,
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
})
vim.lsp.enable("yamlls")

-- C/C++ (clangd)
vim.lsp.config("clangd", {
	capabilities = capabilities,
	on_attach = on_attach,
})
vim.lsp.enable("clangd")
