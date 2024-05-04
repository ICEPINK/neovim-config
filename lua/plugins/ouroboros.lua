return {
    'jakemason/ouroboros',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('ouroboros').setup({
            extension_preferences_table = {
                c = {h = 2, hpp = 1},
                h = {c = 2, cpp = 1},
                cpp = {hpp = 2, h = 1},
                hpp = {cpp = 2, c = 1},
            },
            switch_to_open_pane_if_possible = true,
        })
        vim.keymap.set('n', '<leader>x', vim.cmd.Ouroboros, { desc = 'Ouroboros -> switch' })
    end,
}
