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
-- JAR URI HANDLER (for kotlin-lsp jar:// navigation)
-- ============================================================================

-- kotlin-lsp returns jar:// URIs for external dependencies (e.g. library sources).
-- Neovim can't open these directly, so we extract the file from the JAR and cache it locally.
local function extract_jar_uri(uri)
	-- URI format: jar:///path/to/file.jar!/internal/path/File.kt
	local jar_path = uri:match("^jar://(/[^!]+)!/")
	local internal_path = uri:match("^jar://[^!]+!/(.+)")
	if not jar_path or not internal_path then
		return nil
	end

	local cache_dir = vim.fn.stdpath("cache") .. "/kotlin-jar-sources"
	local output_file = cache_dir .. "/" .. internal_path
	vim.fn.mkdir(vim.fn.fnamemodify(output_file, ":h"), "p")

	-- Extract only if not already cached
	if vim.fn.filereadable(output_file) == 0 then
		local content = vim.fn.system({ "unzip", "-p", jar_path, internal_path })
		if vim.v.shell_error == 0 then
			vim.fn.writefile(vim.split(content, "\n", { plain = true }), output_file)
		end
	end

	return vim.fn.filereadable(output_file) == 1 and output_file or nil
end

-- Custom gd for Kotlin: bypasses fzf-lua and Neovim's internal buf.lua handler,
-- both of which don't handle jar:// URIs. Makes the LSP request directly,
-- rewrites jar:// URIs if needed, then navigates manually.
local function kotlin_go_to_definition()
	local params = vim.lsp.util.make_position_params()
	vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result)
		if err or not result then
			return
		end

		-- Normalize: single Location or array of Locations
		local locations = (result.uri or result.targetUri) and { result } or result
		if vim.tbl_isempty(locations) then
			return
		end

		local loc = locations[1]
		local uri = loc.uri or loc.targetUri
		if uri and uri:match("^jar://") then
			local file_path = extract_jar_uri(uri)
			if file_path then
				uri = vim.uri_from_fname(file_path)
			end
		end

		-- Push current position to jump list so ^o navigates back
		vim.cmd("normal! m'")
		vim.cmd("edit " .. vim.fn.fnameescape(vim.uri_to_fname(uri)))
		local range = loc.range or loc.targetSelectionRange or loc.targetRange
		if range then
			vim.api.nvim_win_set_cursor(0, { range.start.line + 1, range.start.character })
		end
	end)
end

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
    -- Override gd for Kotlin to handle jar:// URIs
		if vim.bo[ev.buf].filetype == "kotlin" then
			vim.keymap.set("n", "gd", kotlin_go_to_definition, vim.tbl_extend("force", opts, { desc = "Definition" }))
		end
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
	kotlin_lsp = {
		single_file_support = false,
	},
	pyright = {
		settings = {},
	},
	ts_ls = {
		settings = {},
	},
	ansiblels = {
		settings = {
			ansible = {
				ansibleLint = {
					enabled = true,
				},
			},
		},
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
	vim.lsp.config(
		server,
		vim.tbl_extend("force", {
			capabilities = capabilities,
		}, config)
	)
	vim.lsp.enable(server)
end

