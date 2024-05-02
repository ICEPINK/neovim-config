return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
        require('mini.ai').setup({ n_lines = 500 })
        -- require('mini.surround').setup()
        require('mini.statusline').setup()
        -- require('mini.comment').setup()
        -- require('mini.indentscope').setup()
    end,
}
