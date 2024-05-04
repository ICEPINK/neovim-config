local function bind_keymaps(lsp_name)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover,
    { buffer = 0, desc = string.format('LSP -> %s -> hover', lsp_name) })
    vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition,
    { buffer = 0, desc = string.format('LSP -> %s -> type_definition', lsp_name) })
    vim.keymap.set('n', 'gd', vim.lsp.buf.declaration,
    { buffer = 0, desc = string.format('LSP -> %s -> declaration', lsp_name) })
    vim.keymap.set('n', 'gD', vim.lsp.buf.definition,
    { buffer = 0, desc = string.format('LSP -> %s -> definition', lsp_name) })
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

return {
    'neovim/nvim-lspconfig',
    config = function()
        local lspconfig = require('lspconfig')
        lspconfig.clangd.setup {
            cmd = { 'clangd', '--completion-style=detailed', '--header-insertion=never' },
            on_attach = function()
                bind_keymaps('clangd')
            end
        }
    end
}
