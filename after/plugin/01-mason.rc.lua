-- ============================================================================
-- after/plugin/mason.rc.lua
-- ============================================================================
-- Mason package manager for LSP servers, formatters, and linters
-- ============================================================================

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

-- ============================================================================
-- MASON SETUP
-- ============================================================================

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- ============================================================================
-- MASON-LSPCONFIG SETUP
-- ============================================================================

mason_lspconfig.setup({
	ensure_installed = {
		"gopls",
		"lua_ls",
		"pyright",
		"yamlls",
		"kotlin_language_server",
	},
	auto_install = true,
	automatic_enable = false,
})
