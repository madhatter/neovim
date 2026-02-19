local status, lualine = pcall(require, 'lualine')
if (not status) then return end

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

