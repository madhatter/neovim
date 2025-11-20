-- Safe requires for plugins
local cmp_setup, cmp = pcall(require, "cmp")
if not cmp_setup then return end

local lspkind_setup, lspkind = pcall(require, "lspkind")
if not lspkind_setup then return end

local cmp_nvim_lsp_setup, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_setup then return end

local mason_setup, mason = pcall(require, "mason")
if not mason_setup then return end

local mason_lspc_setup, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspc_setup then return end

-- Use new lspconfig API if available
local lspconfig = nil
if vim.lsp.config ~= nil then
  lspconfig = vim.lsp.config
else
  -- fallback for old versions
  local ok, lc = pcall(require, "lspconfig")
  if not ok then return end
  lspconfig = lc
end

cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
        require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
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
      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
    })
  },
  sources = cmp.config.sources({
    { name = "copilot", group_index = 2 },
    { name = 'nvim_lsp', group_index = 2 },
    { name = 'luasnip', group_index = 2 },
    { name = 'buffer', group_index = 2 },
  })
})

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
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>.", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	end,
})

-- function to enable/disable autocompletion mode of cmp
function SetAutoCmp(mode)
  if mode then
    cmp.setup({
      completion = {
        autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged }
      }
    })
  else
    cmp.setup({
      completion = {
        autocomplete = false
      }
    })
  end
end
SetAutoCmp(true)

vim.cmd('command AutoCmpOn lua SetAutoCmp(true)')
vim.cmd('command AutoCmpOff lua SetAutoCmp(false)')

-- Mason general setup
mason.setup {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
}

-- Mason ensure installation of LSPs
mason_lspconfig.setup {
    ensure_installed = { "gopls", "lua_ls", "pyright", "yamlls", "kotlin_language_server" },
    auto_install = true,
}

-- on_attach function definition
local on_attach = function(client, bufnr)
  -- You can add buffer local keymaps/settings here if needed
end

-- Configure LSPs using new API if available
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = function(client, bufnr)
  -- (deine eigenen Mappings und andere Logik)
end

-- Go (gopls)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.lsp.start({
      name = "gopls",
      cmd = { "gopls" },
      root_dir = vim.fs.dirname(vim.fs.find({ "go.mod" }, { upward = true })[1]),
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
        }
      },
    })
  end,
})

-- Kotlin (kotlin_language_server)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "kotlin",
  callback = function()
    vim.lsp.start({
      name = "kotlin_language_server",
      cmd = {"kotlin-language-server"},
      root_dir = vim.fs.dirname(vim.fs.find({ "settings.gradle.kts", "settings.gradle" }, { upward = true })[1]),
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        compiler = {
          jvm = {
            target = "20"
          }
        }
      }
    })
  end,
})

-- Python (pyright)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.lsp.start({
      name = "pyright",
      cmd = {"pyright-langserver", "--stdio"},
      root_dir = vim.fs.dirname(vim.fs.find({ "pyproject.toml", "setup.py" }, { upward = true })[1]),
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
})

-- Typescript (tsserver, falls ts_ls)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  callback = function()
    vim.lsp.start({
      name = "tsserver",
      cmd = {"typescript-language-server", "--stdio"},
      root_dir = vim.fs.dirname(vim.fs.find({ "package.json", "tsconfig.json" }, { upward = true })[1]),
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
})

-- Lua (lua_ls)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.lsp.start({
      name = "lua_ls",
      cmd = {"lua-language-server"},
      root_dir = vim.fs.dirname(vim.fs.find({ ".luarc.json", ".luarc.jsonc", "init.lua" }, { upward = true })[1]),
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } }
        }
      }
    })
  end,
})

-- YAML (yamlls)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  callback = function()
    vim.lsp.start({
      name = "yamlls",
      cmd = {"yaml-language-server", "--stdio"},
      root_dir = vim.fs.dirname(vim.fs.find({ "yarn.lock", "package.json" }, { upward = true })[1]),
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        yaml = {
          format = { enable = true },
          hover = true,
          completion = true,
          customTags = {
            "!fn", "!And", "!If", "!Not", "!Equals", "!Or", "!FindInMap sequence",
            "!Base64", "!Cidr", "!Ref", "!Ref Scalar", "!Sub", "!GetAtt", "!GetAZs",
            "!ImportValue", "!Select", "!Split", "!Join sequence"
          },
        },
      },
    })
  end,
})

-- C/C++ (clangd)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp" },
  callback = function()
    vim.lsp.start({
      name = "clangd",
      cmd = { "clangd", "--background-index" },
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "c", "cpp", "objc", "objcpp" },
      init_options = {
        clangdFileStatus = true
      }
    })
  end,
})
