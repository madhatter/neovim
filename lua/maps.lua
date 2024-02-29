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

-- Command-T keybindings
keymap.set('n', '<Leader>o', ':CommandT<CR>')
keymap.set('n', '<Leader>O', ':CommandTFlush<CR>')
keymap.set('n', '<Leader>b', ':CommandTBuffer<CR>')
