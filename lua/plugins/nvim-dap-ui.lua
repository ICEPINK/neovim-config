return {
    'rcarriga/nvim-dap-ui',
    dependencies = {
        'mfussenegger/nvim-dap',
        'nvim-neotest/nvim-nio'
    },
    config = function()
        require("dapui").setup()
        vim.keymap.set('n', '<f12>', function() require("dapui").toggle() end, { desc = 'dapui -> toggle' })
    end
}
