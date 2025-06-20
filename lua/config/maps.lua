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
--keymap.set('n', '<Leader>c', ':close<CR>')

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

-- Neotree keybindings
keymap.set('n', '<F5>', ':Neotree toggle<CR>')

-- folding
keymap.set('n', '<Space>', 'za')

-- move lines in visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- replace the word I'm on
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")
keymap.set("n", "<leader>ms", function() require("myeyeshurt").start() end, {noremap = true, silent = true})
keymap.set("n", "<leader>mx", function() require("myeyeshurt").stop() end, {noremap = true, silent = true})

-- format JSON
keymap.set("n", "<leader>J", "<cmd>%!jq '.'<CR>")
