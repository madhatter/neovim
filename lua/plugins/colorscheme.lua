return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false, -- Load on startup
		priority = 1000, -- High priority to load this colorscheme first
		config = function()
			-- 1. Konfiguration (Setup)
			require("kanagawa").setup({
				theme = "dragon", -- Chosen theme variant, does not seem to matter if set to kanagawa later
				overrides = function(colors)
					local palette = colors.palette
					local theme = colors.theme
					return {
						--Pmenu = { bg = palette.sumiInk0 },
						Pmenu = {
							bg = palette.sumiInk0,
							--fg = "#DCDCDC",
              fg = palette.dragonWhite,
						},
						--FloatBorder = { fg = palette.oldWhite, bg = palette.sumiInk0 },
						FloatBorder = { fg = "#54546D", bg = palette.sumiInk0 },

						--PmenuSel = { bg = palette.waveBlue2, fg = palette.oldWhite, bold = true },
						PmenuSel = { bg = palette.waveBlue2, fg = palette.oldWhite, bold = true },
					}
				end,
			})
			vim.cmd("colorscheme kanagawa-dragon") -- 2. Farbenchema setzen
		end,
	},
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
				},
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
		end,
	},
	{
		"wildfunctions/myeyeshurt",
		opts = {},
	},
}
