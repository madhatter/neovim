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

      local banners = {
        { --figlet -f graffiti
          [[                          __         .__          .__          ]],
          [[     ____   ____  _______/  |______  |  |    ____ |__|__  ___  ]],
          [[    /    \ /  _ \/  ___/\   __\__  \ |  |   / ___\|  \  \/  /  ]],
          [[   |   |  (  <_> )___ \  |  |  / __ \|  |__/ /_/  >  |>    <   ]],
          [[   |___|  /\____/____  > |__| (____  /____/\___  /|__/__/\_ \  ]],
          [[        \/           \/            \/     /_____/          \/  ]],
        },
        { --figlet -f graffiti
          [[                        .___.__            __    __                  ]],
          [[      _____ _____     __| _/|  |__ _____ _/  |__/  |_  ___________   ]],
          [[     /     \\__  \   / __ | |  |  \\__  \\   __\   __\/ __ \_  __ \  ]],
          [[    |  Y Y  \/ __ \_/ /_/ | |   Y  \/ __ \|  |  |  | \  ___/|  | \/  ]],
          [[    |__|_|  (____  /\____ | |___|  (____  /__|  |__|  \___  >__|     ]],
          [[          \/     \/      \/      \/     \/                \/         ]],
        }
      }

      startify.section.header.val = banners[2]

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
  {
    "wildfunctions/myeyeshurt",
    opts = {}
  },
}
