local keymap = vim.keymap

-- Do not yank with x
keymap.set('n', 'x', '"_x')

-- Increment/decrement numbers
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- New tab
keymap.set('n', 'te', ':tabedit<Return>', { silent = true })
-- New splits
keymap.set('n', 'ss', ':split<Return><C-w>w', { silent = true })
keymap.set('n', 'sv', ':vsplit<Return><C-w>w', { silent = true })
-- Close window
keymap.set('n', '<Leader>c', ':close<CR>')

-- Resize window
keymap.set('', '<C-w><left>', '<C-w><')
keymap.set('', '<C-w><up>', '<C-w>+')
keymap.set('', '<C-w><down>', '<C-w>-')
keymap.set('', '<C-w><right>', '<C-w>>')

-- Navigator settings
keymap.set('', '<C-h>', ':TmuxNavigateLeft<CR>')
keymap.set('', '<C-l>', ':TmuxNavigateRight<CR>')
keymap.set('', '<C-k>', ':TmuxNavigateUp<CR>')
keymap.set('', '<C-j>', ':TmuxNavigateDown<CR>')

-- fzf-lua keybindings
keymap.set('n', '<Leader>o', ':FzfLua files<CR>')
keymap.set('n', '<Leader>h', ':FzfLua oldfiles<CR>')
keymap.set('n', '<Leader>b', ':FzfLua buffers<CR>')
