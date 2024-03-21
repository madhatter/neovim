return {
	"rebelot/kanagawa.nvim",
  -- welcome screen
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
		  local alpha = require("alpha")
		  local startify = require("alpha.themes.startify")

      startify.section.header.val = {
        [[                          __         .__          .__          ]],
        [[     ____   ____  _______/  |______  |  |    ____ |__|__  ___  ]],
        [[    /    \ /  _ \/  ___/\   __\__  \ |  |   / ___\|  \  \/  /  ]],
        [[   |   |  (  <_> )___ \  |  |  / __ \|  |__/ /_/  >  |>    <   ]],
        [[   |___|  /\____/____  > |__| (____  /____/\___  /|__/__/\_ \  ]],
        [[        \/           \/            \/     /_____/          \/  ]],
      }

      --startify.nvim_web_devicons.highlight = true
      --startify.nvim_web_devicons.highlight = 'Keyword'

      startify.section.footer.val = {
        { type = "text", val = " \n \n \n \nThis will all end in tears.\n Marvin." },
      }

      -- Send config to alpha
		  alpha.setup(startify.config)

		  -- Disable folding on alpha buffer
		  vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end
  },
}
