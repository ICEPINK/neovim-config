return {
    'nvim-treesitter/nvim-treesitter',
    config = function()
        vim.cmd.TSUpdate()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
            sync_install = false,
            auto_install = true,
            ignore_install = {},
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        }
    end
}
