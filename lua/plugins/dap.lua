return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "leoluz/nvim-dap-go",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio"
  },
  config = function()
    local dap, dapui, dapgo = require("dap"), require("dapui"), require("dap-go")

    dapui.setup()
    dapgo.setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
  keys = {
    { "<leader>dt", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle debugger breakpoint" },
    { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue running debugger" },
    { "<leader>dx", "<cmd>DapTerminate<cr>", desc = "Kill Debugger" },
    { "<leader>ds", "<cmd>DapStepOver<cr>", desc = "Step over Debugger" },
    { "<leader>du", "<cmd>DapToggleRepl<cr>", desc = "open Debugger Repl" },
  },
}
