local run_args = ''

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Custom -> diagnostic.open_float' })
vim.keymap.set('n', '<esc>', vim.cmd.nohlsearch, { desc = 'Custom -> nohlsearch' })
vim.keymap.set('n', '<f5>', function() vim.cmd('!lua .nvim/run.lua ' .. run_args) end, { desc = 'Custom -> nohlsearch' })
vim.keymap.set('n', '<f6>', function() run_args = vim.fn.input("run.lua args: ") end, { desc = 'Custom -> run args' })
