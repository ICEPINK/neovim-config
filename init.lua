-- init.lua --------------------------------------------------------------------

-- leader ----------------------------------------------------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- options ---------------------------------------------------------------------
vim.opt.breakindent = true
vim.opt.cinoptions = 'l1,g0,N-s,E-s,+0'
vim.opt.conceallevel = 1
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.foldlevel = 100
vim.opt.foldmethod = 'indent'
vim.opt.foldminlines = 0
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.langmenu = 'none'
vim.opt.linebreak = true;
vim.opt.list = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.path:append('**')
vim.opt.relativenumber = false
vim.opt.shiftwidth = 4
vim.opt.showmode = true
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 1000
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.wrap = false

-- plugins ---------------------------------------------------------------------
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
    spec = {
        {
            'folke/tokyonight.nvim',
            lazy = false, -- make sure we load this during startup if it is your main colorscheme
            priority = 1000, -- make sure to load this before all the other start plugins
            config = function()
                vim.cmd('colorscheme tokyonight-night');
            end,
        },
        {
            'nvim-treesitter/nvim-treesitter',
            branch = 'master',
            lazy = false,
            build = ':TSUpdate',
            config = {
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
                sync_install = false,
                auto_install = true,
                ignore_install = {},
                highlight = {
                    enable = true,
                    disable = {},
                    additional_vim_regex_highlighting = false,
                },
            },
        },
        {
            'neovim/nvim-lspconfig',
        },
        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.8',
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
                vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Telescope -> git_files'})
                vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope -> help_tags'})
                vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope -> keymaps'})
                vim.keymap.set('n', '<leader>ft', builtin.treesitter, { desc = 'Telescope -> Treesitter'})
                vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'Telescope -> lsp_references'})
                vim.keymap.set('n', '<leader>fw', builtin.lsp_dynamic_workspace_symbols, { desc = 'Telescope -> lsp_dynamic_workspace_symbols'})
                vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Telescope -> lsp_document_symbols'})
                vim.keymap.set('n', '<leader>fn', vim.cmd.TodoTelescope, { desc = 'Telescope -> TodoTelescope'})
            end
        },
        {
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
        },
        {
            'mbbill/undotree',
            config = function()
                vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Undotree -> Toggle' })
                vim.g.undotree_WindowLayout = 4
                vim.g.undotree_SetFocusWhenToggle = 1
                vim.g.undotree_DiffAutoOpen = 0
                vim.g.undotree_DiffCommand = 'git diff --no-index'
            end
        },
        {
            'tpope/vim-fugitive',
        },
        {
            'lewis6991/gitsigns.nvim',
            config = function()
                require('gitsigns').setup {
                    signs = {
                        add          = { text = '+' },
                        change       = { text = '~' },
                        delete       = { text = '_' },
                        topdelete    = { text = '‾' },
                        changedelete = { text = '~' },
                        untracked    = { text = '┆' },
                    },
                }
            end
        },
        {
            'MeanderingProgrammer/render-markdown.nvim',
            dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
            -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
            -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
            ---@module 'render-markdown'
            ---@type render.md.UserConfig
            opts = {},
        },
    },
    install = { colorscheme = { 'default' } },
    checker = { enabled = false },
})

-- cmd -------------------------------------------------------------------------
vim.cmd.language('en')
vim.cmd.command('Run !lua .nvim\\run.lua')

-- keymaps ---------------------------------------------------------------------
local run_args = ''
local run_cmd = 'lua'
local run_file = '.nvim/run.lua'
vim.keymap.set('n', '<leader><f1>', function() vim.cmd.edit(vim.fn.stdpath('config') .. '/init.lua') end, { desc = 'Custom -> edit init.lua' })
vim.keymap.set('n', '<esc>', function() vim.cmd('nohlsearch') end, { desc = 'Custom -> nohlsearch' })
vim.keymap.set('n', '<f5>', ':!' .. run_cmd .. ' ' .. run_file .. ' ' .. run_args .. '<CR>', { desc = 'Custom -> run.lua' })
vim.keymap.set('n', '<s-f5>', function() vim.ui.input({ prompt = 'run args: ', default = run_args }, function(input) run_args = input end) end, { desc = 'Custom -> run args' })
vim.keymap.set('n', '<c-f5>', function() vim.cmd.edit(run_file) end, { desc = 'Custom -> open run_file' })
vim.keymap.set('n', '<cs-f5>', function() vim.ui.input({ prompt = 'run command: ', default = run_cmd }, function(input) run_cmd = input end) vim.ui.input({ prompt = 'run file: ', default = run_file }, function(input) run_file = input end) end, { desc = 'Custom -> change run command' })
vim.keymap.set('n', '<leader>i', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = 'Custom -> lsp.inlay_hint' })
vim.keymap.set('n', '<leader>w', function() vim.opt.wrap = not vim.opt.wrap:get() end, { desc = 'Custom -> toggle word wrap' })
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Custom -> exit terminal mode' })
