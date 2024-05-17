local run_args = ''
vim.keymap.set('n', '<esc>', vim.cmd.nohlsearch, { desc = 'Custom -> nohlsearch' })
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Custom -> exit terminal mode' })
vim.keymap.set('n', '<f5>', function() vim.cmd('!lua .nvim/run.lua ' .. run_args) end, { desc = 'Custom -> nohlsearch' })
vim.keymap.set('n', '<f6>', function() vim.ui.input({ prompt = 'run.lua args: ', default = run_args }, function(input) run_args = input end) end, { desc = 'Custom -> run args' })
vim.keymap.set('n', '<f12>', function() vim.cmd.edit('.nvim/run.lua') end, { desc = 'Custom -> open .nvim/run.lua' })
vim.keymap.set('n', '<leader>i', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = 'Custom -> lsp.inlay_hint' })
