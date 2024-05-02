return {
    'mbbill/undotree',
    config = function()
        vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Undotree -> Toggle' })
        vim.g.undotree_WindowLayout = 4
        vim.g.undotree_SetFocusWhenToggle = 1
    end
}
