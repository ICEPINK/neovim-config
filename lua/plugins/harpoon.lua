return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup()
        vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end, { desc = 'Harpoon -> add'})
        vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon -> menu'})
        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = 'Harpoon -> sel 1'})
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = 'Harpoon -> sel 2'})
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = 'Harpoon -> sel 3'})
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = 'Harpoon -> sel 4'})
    end,
}
