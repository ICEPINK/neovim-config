---@diagnostic disable: undefined-global
-- # Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- # Options
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.colorcolumn = '80'
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.guicursor = ''
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.langmenu = "none"
vim.opt.list = true
vim.opt.listchars = { tab = '→ ', trail = '·', eol = '‹', nbsp = '␣' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.timeoutlen = 1000
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.wrap = false

-- # Cmd
vim.cmd.language("en")

-- # Keymaps
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Custom -> Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Custom -> Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Custom -> Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Custom -> Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Custom -> Move focus to the upper window' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Custom -> Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Custom -> Go to next diagnostic' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Custom -> Diagnostic open float' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Custom -> Diagnostic set local list' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Custom -> No highlight search' })

-- # Plugins
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme('tokyonight-night')
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query' },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'folke/neodev.nvim',
                opts = {},
            },
        },
        config = function()
            local function bind_keymaps(lsp_name)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover,
                    { buffer = 0, desc = string.format('LSP -> %s -> hover', lsp_name) })
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
                    { buffer = 0, desc = string.format('LSP -> %s -> definition', lsp_name) })
                vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition,
                    { buffer = 0, desc = string.format('LSP -> %s -> type_definition', lsp_name) })
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
                    { buffer = 0, desc = string.format('LSP -> %s -> declaration', lsp_name) })
                vim.keymap.set('n', 'gI', vim.lsp.buf.implementation,
                    { buffer = 0, desc = string.format('LSP -> %s -> implementation', lsp_name) })
                vim.keymap.set('n', 'gr', vim.lsp.buf.references,
                    { buffer = 0, desc = string.format('LSP -> %s -> references', lsp_name) })
                vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help,
                    { buffer = 0, desc = string.format('LSP -> %s -> signature_help', lsp_name) })
                vim.keymap.set('n', '<F2>', vim.lsp.buf.rename,
                    { buffer = 0, desc = string.format('LSP -> %s -> rename', lsp_name) })
                vim.keymap.set('n', '<F3>', vim.lsp.buf.format,
                    { buffer = 0, desc = string.format('LSP -> %s -> format', lsp_name) })
                vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action,
                    { buffer = 0, desc = string.format('LSP -> %s -> code_action', lsp_name) })
            end

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
                callback = function(event)
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.server_capabilities.documentHighlightProvider then
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end
                end,
            })

            require('neodev').setup({})

            local cmp_nvim_lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
            cmp_nvim_lsp_capabilities = vim.tbl_deep_extend('force', cmp_nvim_lsp_capabilities,
                require('cmp_nvim_lsp').default_capabilities())

            require('lspconfig').rust_analyzer.setup {
                capabilities = cmp_nvim_lsp_capabilities,
                on_attach = function()
                    bind_keymaps('rust_analyzer')
                end
            }
            require('lspconfig').clangd.setup {
                capabilities = cmp_nvim_lsp_capabilities,
                cmd = { 'clangd', '--completion-style=detailed', '--header-insertion=never' },
                on_attach = function()
                    bind_keymaps('clangd')
                end
            }
            require('lspconfig').cmake.setup {
                cmd = { '/home/icepink/.python-venv/bin/cmake-language-server' },
                capabilities = cmp_nvim_lsp_capabilities,
                on_attach = function()
                    bind_keymaps('cmake')
                end
            }
            require('lspconfig').lua_ls.setup {
                capabilities = cmp_nvim_lsp_capabilities,
                on_attach = function()
                    bind_keymaps('lua')
                end
            }
            require('lspconfig').bashls.setup {
                capabilities = cmp_nvim_lsp_capabilities,
                on_attach = function()
                    bind_keymaps('bash')
                end
            }
            require('lspconfig').texlab.setup {
                capabilities = cmp_nvim_lsp_capabilities,
                on_attach = function()
                    bind_keymaps('texlab')
                end
            }
        end
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            {
                'L3MON4D3/LuaSnip',
                config = function()
                    return 'make install_jsregexp'
                end,
            },
            'saadparwaiz1/cmp_luasnip'
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {},
                -- completion = { completeopt = 'menu,menuone,noinsert' },
                mapping = cmp.mapping.preset.insert({
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete({}),
                    ['<C-l>'] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { 'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lua' },
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'luasnip' }, -- For luasnip users.
                }, {
                    { name = 'buffer' },
                }),
            })
        end
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            {
                'rcarriga/nvim-dap-ui',
                config = function()
                    require('dapui').setup()
                    vim.keymap.set('n', '<Leader>du', function() require('dapui').toggle() end,
                        { desc = 'Dap-UI -> toggle' })
                end
            },
        },
        config = function()
            local dap = require('dap')
            vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = 'Dap -> continue' })
            vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = 'Dap -> step_over' })
            vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = 'Dap -> step_into' })
            vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = 'Dap -> step_out' })
            vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end,
                { desc = 'Dap -> toggle_breakpoint' })
            vim.keymap.set('n', '<Leader>dB',
                function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
                { desc = 'Dap -> set_breakpoint -> message' })
            vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end, { desc = 'Dap -> repl -> open' })
            vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end, { desc = 'Dap -> run_last' })
            vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
                require('dap.ui.widgets').hover()
            end, { desc = 'Dap -> hover' })
            vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
                require('dap.ui.widgets').preview()
            end, { desc = 'Dap -> preview' })
            vim.keymap.set('n', '<Leader>df', function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.frames)
            end, { desc = 'Dap -> centered_float -> frames' })
            vim.keymap.set('n', '<Leader>ds', function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.scopes)
            end, { desc = 'Dap -> centered_float -> scopes' })

            dap.adapters.gdb = {
                type = 'executable',
                command = 'gdb',
                args = { '-i', 'dap' }
            }

            dap.adapters.lldb = {
                type = 'executable',
                command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
                name = 'lldb'
            }

            dap.configurations.cpp = {
                {
                    name = 'Launch',
                    type = 'lldb',
                    request = 'launch',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    args = {},
                },
            }
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        event = 'VeryLazy',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup({})

            local telescope = require('telescope.builtin')
            vim.keymap.set('n', '<leader>sh', telescope.help_tags, { desc = 'Telescope -> help_tags' })
            vim.keymap.set('n', '<leader>sk', telescope.keymaps, { desc = 'Telescope -> keymaps' })
            vim.keymap.set('n', '<leader>sf', telescope.find_files, { desc = 'Telescope -> find_files' })
            vim.keymap.set('n', '<leader>sg', telescope.git_files, { desc = 'Telescope -> git_files' })
            vim.keymap.set('n', '<leader>ss', telescope.builtin, { desc = 'Telescope -> builtin' })
            vim.keymap.set('n', '<leader>sw', telescope.grep_string, { desc = 'Telescope -> grep_string' })
            vim.keymap.set('n', '<leader>sa', telescope.live_grep, { desc = 'Telescope -> live_grep' })
            vim.keymap.set('n', '<leader>sc', telescope.current_buffer_fuzzy_find,
                { desc = 'Telescope -> current_buffer_fuzzy_find' })
            vim.keymap.set('n', '<leader>sd', telescope.diagnostics, { desc = 'Telescope -> diagnostics' })
            vim.keymap.set('n', '<leader>sr', telescope.resume, { desc = 'Telescope -> resume' })
            vim.keymap.set('n', '<leader>sq', telescope.command_history, { desc = 'Telescope -> command_history' })
            vim.keymap.set('n', '<leader>s.', telescope.oldfiles, { desc = 'Telescope -> oldfiles' })
            vim.keymap.set('n', '<leader>s:', telescope.commands, { desc = 'Telescope -> commands' })
            vim.keymap.set('n', '<leader>sll', telescope.lsp_dynamic_workspace_symbols,
                { desc = 'Telescope -> lsp_dynamic_workspace_symbols' })
            vim.keymap.set('n', '<leader>slr', telescope.lsp_references,
                { desc = 'Telescope -> lsp_references' })
            vim.keymap.set('n', '<leader>slt', telescope.lsp_type_definitions,
                { desc = 'Telescope -> lsp_type_definitions' })
            vim.keymap.set('n', '<leader>sld', telescope.lsp_document_symbols,
                { desc = 'Telescope -> lsp_document_symbols' })
            vim.keymap.set('n', '<leader><Space>', telescope.buffers, { desc = 'Telescope -> buffers' })
        end,
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local harpoon = require('harpoon')
            harpoon:setup()

            vim.keymap.set('n', '<leader>hh', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
                { desc = 'Harpoon -> toggle quick menu' })
            vim.keymap.set('n', '<leader>ha', function() harpoon:list():append() end,
                { desc = 'Harpoon -> append' })
            vim.keymap.set('n', '<leader>q', function() harpoon:list():select(1) end, { desc = 'Harpoon -> list 1' })
            vim.keymap.set('n', '<leader>w', function() harpoon:list():select(2) end, { desc = 'Harpoon -> list 2' })
            vim.keymap.set('n', '<leader>e', function() harpoon:list():select(3) end, { desc = 'Harpoon -> list 3' })
            vim.keymap.set('n', '<leader>r', function() harpoon:list():select(4) end, { desc = 'Harpoon -> list 4' })
        end
    },
    {
        'tpope/vim-fugitive'
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Undotree -> Toggle' })

            vim.g.undotree_WindowLayout = 4
            vim.g.undotree_SetFocusWhenToggle = 1
        end
    },
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
            '3rd/image.nvim',              -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
            vim.keymap.set('n', '<leader>n', function() vim.cmd.Neotree('position=current', 'toggle', 'reveal') end, { desc = 'Neotree -> toggle' })
            require('neo-tree').setup({
                filesystem = {
                    hijack_netrw_behavior = 'open_current',
                },
            })
        end
    },
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false },
    },
    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
        },
        config = function()
            vim.keymap.set('n', '<leader>x', function() require('trouble').toggle() end, { desc = 'Trouble -> toggle' })
        end
    },
    {
        'echasnovski/mini.nvim',
        version = false,
        config = function()
            require('mini.ai').setup({ n_lines = 500 })
            require('mini.surround').setup()
            require('mini.statusline').setup()
            require('mini.comment').setup()
            require('mini.indentscope').setup()
        end,
    },
}
local opts = {}

require('lazy').setup(plugins, opts)
