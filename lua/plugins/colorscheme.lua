return {
	{
		-- Replicates NvChad's base46 gruvbox theme without requiring NvChad.
		-- The 16 base colors are taken directly from:
		-- https://github.com/NvChad/base46/blob/v2.0/lua/base46/themes/gruvbox.lua
		"RRethy/nvim-base16",
		lazy = false,
		priority = 1000,
		config = function()
			require("base16-colorscheme").setup({
				base00 = "#282828", -- background
				base01 = "#3c3836", -- lighter background
				base02 = "#504945", -- selection background
				base03 = "#665c54", -- comments
				base04 = "#bdae93", -- dark foreground
				base05 = "#d5c4a1", -- default foreground
				base06 = "#ebdbb2", -- light foreground
				base07 = "#fbf1c7", -- lightest foreground
				base08 = "#fb4934", -- red (errors, deletes)
				base09 = "#fe8019", -- orange
				base0A = "#fabd2f", -- yellow (keywords)
				base0B = "#b8bb26", -- green (strings)
				base0C = "#8ec07c", -- cyan
				base0D = "#83a598", -- blue (functions)
				base0E = "#d3869b", -- purple
				base0F = "#d65d0e", -- dark orange
			})
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
