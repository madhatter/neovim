# Neovim Configuration

> Personal Neovim setup — minimal by design, powerful in practice.

No big frameworks. No magic. Just a well-understood set of plugins wired together with plain Lua. Every piece is here for a reason, and you can read it all in an afternoon.

> **Warning:** This is a personal configuration. Use it as inspiration rather than copying it wholesale — some paths (e.g. Python binary) are hardcoded for macOS/Homebrew.

---

## Requirements

| Dependency | Notes |
|---|---|
| Neovim ≥ 0.10 | Required for `vim.uv` (libuv bindings) |
| [git](https://git-scm.com/) | Plugin manager bootstrap |
| [Nerd Font](https://www.nerdfonts.com/) | Icons in Neo-tree, lualine, etc. |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Used by fzf-lua for live grep |
| [Node.js](https://nodejs.org/) | Copilot, markdown-preview build |

**Optional but recommended:** tmux + [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) for seamless pane/window navigation.

**Formatters** (install via your package manager as needed): `stylua`, `black`, `isort`, `prettierd`, `gofmt`, `ktfmt`, `rustfmt`, `terraform`, `yamlfmt`

---

## Installation

```sh
# Back up any existing config first
mv ~/.config/nvim ~/.config/nvim.bak

git clone <this-repo> ~/.config/nvim
nvim
```

On first launch, [lazy.nvim](https://github.com/folke/lazy.nvim) will bootstrap itself and install all plugins automatically. LSP servers are managed by Mason and will be installed on demand.

---

## Structure

```
init.lua                    # Entry point
lua/
  config/
    base.lua                # Core editor options (leader key, tabs, performance)
    maps.lua                # All keymaps
    autocmd.lua             # Autocommands
    highlights.lua          # Colors and display
    lazy.lua                # Plugin manager bootstrap
  plugins/                  # One file per plugin/group — auto-discovered by lazy.nvim
  custom/
    directory-watcher.lua   # libuv-based FS watcher with debounce
    hotreload.lua           # Auto-reload buffers when files change externally
after/
  plugin/                   # Post-plugin setup, numbered for load order
    01-mason.rc.lua         # LSP server list
    02-lsp.rc.lua           # LSP keybindings and per-server config
    03-nvim-cmp.rc.lua      # Completion setup
    lualine.rc.lua          # Status line
  ftplugin/                 # Per-filetype overrides (go, python)
```

The `after/plugin/` files are numbered (`01-`, `02-`, `03-`) to enforce load order: Mason must be ready before LSP servers are configured, which must be ready before completions are wired up.

---

## Features

### Editor

- **Leader key:** `;`
- **Colorscheme:** [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) (Dragon variant)
- **Fuzzy finding:** [fzf-lua](https://github.com/ibhagwan/fzf-lua) — files, oldfiles, buffers, live grep; custom DuckDB parquet preview
- **File tree:** [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) (`<F5>`)
- **Folding:** [nvim-ufo](https://github.com/kevinhwang91/promise-async) with treesitter + indent providers
- **Welcome screen:** [alpha-nvim](https://github.com/goolord/alpha-nvim) with Figlet ASCII banners

### LSP & Completion

Languages configured out of the box: **Go, Python, Lua, TypeScript, Kotlin, Rust, Terraform, YAML/Ansible, C/C++**

- Servers auto-installed via [mason.nvim](https://github.com/williamboman/mason.nvim)
- Completion via [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) with sources: Copilot, LSP, LuaSnip, buffer
- Snippets via [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- Formatting via [conform.nvim](https://github.com/stevearc/conform.nvim) (`<leader>F`)

### AI

| Tool | Description |
|---|---|
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | Inline suggestions (`<M-l>` to accept) |
| [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim) | Chat panel (`<leader>cc*`) |
| [opencode.nvim](https://github.com/nickjvandyke/opencode.nvim) | OpenCode integration (`<C-a>`, `<F1>`) |
| `<leader>ac` | Claude CLI in a vertical split |
| `<leader>ai` | Gemini CLI in a vertical split |

### Git

- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) — hunk staging, preview, inline blame
- [neogit](https://github.com/NeogitOrg/neogit) — Magit-style Git UI (`<leader>gg`)
- [diffview.nvim](https://github.com/sindrets/diffview.nvim) — side-by-side diffs
- [blame.nvim](https://github.com/FabijanZulj/blame.nvim) — full file blame view

### Testing & Debugging

- [vim-test](https://github.com/vim-test/vim-test) — run tests at any granularity (`<leader>t/T/a/l`)
- [nvim-dap](https://github.com/mfussenegger/nvim-dap) + nvim-dap-go + nvim-dap-ui — full debug adapter with auto-open UI

### Notes

- [obsidian.nvim](https://github.com/epwalsh/obsidian.nvim) — two vaults (`~/vaults/private`, `~/vaults/work`)

---

## Key Mappings

### Navigation

| Key | Action |
|---|---|
| `<leader>o` | Find files (fzf-lua) |
| `<leader>h` | Recent files |
| `<leader>b` | Open buffers |
| `<F5>` | Toggle file tree (Neo-tree) |
| `<C-h/j/k/l>` | Navigate windows/tmux panes |
| `te` / `ss` / `sv` | New tab / horizontal split / vertical split |

### LSP

| Key | Action |
|---|---|
| `gd` / `gD` / `gi` | Go to definition / declaration / implementation |
| `gr` / `gy` | References / type definition |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `[d` / `]d` | Previous / next diagnostic |

### Git

| Key | Action |
|---|---|
| `<leader>gg` | Open Neogit |
| `<leader>gs` / `<leader>gr` | Stage / reset hunk |
| `<leader>gp` / `<leader>gb` | Preview hunk / blame line |
| `<leader>gd` / `<leader>gD` | Diff against index / HEAD |

### Formatting & Code

| Key | Action |
|---|---|
| `<leader>F` | Format file or selection (conform) |
| `<leader>s` | Replace word under cursor (project-wide) |
| `<leader>J` | Format selection as JSON |
| `<leader>rn` | LSP rename |

### Testing & Debugging

| Key | Action |
|---|---|
| `<leader>t` / `<leader>T` | Run nearest test / test file |
| `<leader>a` / `<leader>l` | Run full suite / last test |
| `<leader>dt` | Toggle breakpoint |
| `<leader>dc` / `<leader>ds` | Continue / step over |
| `<leader>du` | Open DAP REPL |

---

## Custom Modules

**`lua/custom/directory-watcher.lua`** — A `vim.uv` fs_event wrapper with named handler registration and configurable debounce (default 100ms). Started in `init.lua` only when Neovim is opened to a directory.

**`lua/custom/hotreload.lua`** — Registers with the directory watcher and also attaches autocmds (`FocusGained`, `TermLeave`, `BufEnter`, etc.) to silently reload unmodified buffers when their files change on disk. Useful when editing files with external tools (formatters, generators) running alongside Neovim.

---

## Philosophy

- Prefer reading and understanding every plugin over having the most plugins
- Lazy-load everything that doesn't need to be immediate
- Keep keybindings consistent and memorable
- Performance first: tuned `updatetime`, `timeoutlen`, debounced watchers, increased lualine refresh intervals
