-- ============================================================================
-- after/plugin/nvim-cmp.rc.lua
-- ============================================================================
-- Pure completion setup - no LSP server config, no Mason
-- ============================================================================

local cmp = require("cmp")
local lspkind = require("lspkind")

-- ============================================================================
-- CMP SETUP
-- ============================================================================

cmp.setup({
	preselect = cmp.PreselectMode.None,
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = {
			border = "rounded",
			winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
			col_offset = -3,
			side_padding = 0,
		},
		documentation = {
			border = "rounded",
			winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
		},
	},
	mapping = cmp.mapping.preset.insert({
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
			symbol_map = { Copilot = "" },
		}),
	},
	sources = cmp.config.sources({
		{ name = "copilot", group_index = 2 },
		{ name = "nvim_lsp", group_index = 2 },
		{ name = "luasnip", group_index = 2 },
		{ name = "buffer", group_index = 2 },
	}),
})


-- ============================================================================
-- HIGHLIGHTS
-- ============================================================================

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

-- ============================================================================
-- AUTO-COMPLETION TOGGLE COMMANDS
-- ============================================================================

local function set_auto_cmp(enabled)
	cmp.setup({
		completion = {
			autocomplete = enabled and { require("cmp.types").cmp.TriggerEvent.TextChanged } or false,
		},
	})
end

-- Initialize with autocompletion enabled
set_auto_cmp(true)

-- Create user commands
vim.api.nvim_create_user_command("AutoCmpOn", function()
	set_auto_cmp(true)
end, {})

vim.api.nvim_create_user_command("AutoCmpOff", function()
	set_auto_cmp(false)
end, {})
