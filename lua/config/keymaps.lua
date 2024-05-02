vim.keymap.set('n', '<leader>', function() print("<leader> test!") end, { desc = 'Custom -> leader test' })
vim.keymap.set('n', '<esc>', vim.cmd.nohlsearch, { desc = 'Custom -> nohlsearch' })
