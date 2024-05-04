return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Telescope -> buffers'})
        vim.keymap.set('n', '<leader>f<leader>', builtin.resume, { desc = 'Telescope -> resume'})
        vim.keymap.set('n', '<leader>fa', builtin.live_grep, { desc = 'Telescope -> live_grep'})
        vim.keymap.set('n', '<leader>fb', builtin.builtin, { desc = 'Telescope -> builtin'})
        vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = 'Telescope -> current_buffer_fuzzy_find'})
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope -> diagnostics'})
        vim.keymap.set('n', '<leader>fD', builtin.lsp_definitions, { desc = 'Telescope -> lsp_definitions'})
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope -> find_files'})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope -> help_tags'})
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope -> keymaps'})
        vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'Telescope -> lsp_references'})
        vim.keymap.set('n', '<leader>fw', builtin.lsp_dynamic_workspace_symbols, { desc = 'Telescope -> lsp_dynamic_workspace_symbols'})
    end
}
