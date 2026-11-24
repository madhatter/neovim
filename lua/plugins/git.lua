return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = '+' },
          change       = { text = '│' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        current_line_blame_opts = {
          delay = 300,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Jump between hunks; keep the built-in ]c/[c inside diff mode
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']c', bang = true })
            else
              gs.nav_hunk('next')
            end
          end)
          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[c', bang = true })
            else
              gs.nav_hunk('prev')
            end
          end)

          map('n', '<leader>gs', gs.stage_hunk)
          map('n', '<leader>gr', gs.reset_hunk)
          map('n', '<leader>gS', gs.stage_buffer)
          map('n', '<leader>gu', gs.undo_stage_hunk)
          map('n', '<leader>gp', gs.preview_hunk)
          map('n', '<leader>gb', function() gs.blame_line{full=true} end)
          map('n', '<leader>tb', function()
            local on = gs.toggle_current_line_blame()
            vim.notify('Line blame ' .. (on and 'on' or 'off'))
          end)
          map('n', '<leader>gd', gs.diffthis)
          map('n', '<leader>gD', function() gs.diffthis('~') end)
          map('n', '<leader>td', gs.preview_hunk_inline)
        end
      })
    end
  },
  {
    "FabijanZulj/blame.nvim",
    config = function()
      require("blame").setup()
    end
  }
}
