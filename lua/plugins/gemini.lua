return {
  {
    "marcinjahn/gemini-cli.nvim",
    event = "VeryLazy",
    dependencies = {
      "folke/snacks.nvim",
    },
    -- We replace 'config = true' with a detailed configuration function
    config = function()
      require("gemini_cli").setup({
        -- Adjust the appearance of the chat window
        chat_win = {
          border = "rounded", -- Other options: "single", "double", "none"
        },
        -- Define your own reusable actions here
        actions = {
          explain = "Explain the following code snippet in detail. Go into the logic, structure, and potential improvements.",
          refactor = "Refactor the following code. Improve readability, performance, and adhere to best practices.",
          test = "Write unit tests for the following code. Use the most common testing framework for this language.",
        },
      })
    end,
    -- Add keymaps for our new actions
    keys = {
      { "<leader>a/", "<cmd>Gemini toggle<cr>", desc = "Toggle Gemini" },
      { "<leader>aa", "<cmd>Gemini ask<cr>", mode = { "n", "v" }, desc = "Ask Gemini (General Question)" },
      { "<leader>af", "<cmd>Gemini add_file<cr>", desc = "Add File to Context" },
      -- New keymaps for custom actions
      { "<leader>ae", "<cmd>Gemini explain<cr>", mode = { "n", "v" }, desc = "Explain Code" },
      { "<leader>ar", "<cmd>Gemini refactor<cr>", mode = { "n", "v" }, desc = "Refactor Code" },
      { "<leader>at", "<cmd>Gemini test<cr>", mode = { "n", "v" }, desc = "Write Tests" },
    },
  },
}
