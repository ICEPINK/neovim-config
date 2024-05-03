local run_args = ''

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Custom -> diagnostic.open_float' })
vim.keymap.set('n', '<esc>', vim.cmd.nohlsearch, { desc = 'Custom -> nohlsearch' })
vim.keymap.set('n', '<f5>', function() vim.cmd('!lua .nvim/run.lua ' .. run_args) end, { desc = 'Custom -> nohlsearch' })
vim.keymap.set('n', '<f6>', function() vim.ui.input({ prompt = 'run.lua args: ', default = run_args }, function(input) run_args = input end) end, { desc = 'Custom -> run args' })
