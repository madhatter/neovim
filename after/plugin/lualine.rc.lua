local status, lualine = pcall(require, 'lualine')
if (not status) then return end

local lsp = {
    function()
        local msg = 'No LSP'
        local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config and client.config.filetypes or nil
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    --icon = icons.ui.Gear,
    icon = '',
    -- use palenight blue color and make the font not bold for a more subtle look
    --color = { fg = '#82aaff', gui = 'none' },
}

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'palenight',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = {},
        refresh = {
            statusline = 1000, -- increased from default for less CPU usage
            tabline = 1000,
            winbar = 1000,
         }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { {
            'filename',
            file_status = true, -- displays file status
            path = 0 -- 0 = just the filename
        } },
        lualine_x = {
            { 'diagnostics', sources = { 'nvim_diagnostic' }, symbols = { error = ' ', warn = ' ', info = ' ' } },
            lsp,
            'encoding',
            'filetype'
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { {
            'filename',
            file_status = true,
            path = 1 -- 1 = relative path
        } },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = { 'fugitive' }
}

