return {
    'mfussenegger/nvim-dap',
    config = function()
        local dap = require('dap')
        dap.adapters.lldb = {
            type = 'executable',
            command = 'C:\\msys64\\clang64\\bin\\lldb-dap.exe',
            name = 'lldb'
        }
        local g_last_exe = ''
        local g_last_args = ''
        dap.configurations.cpp = {
            {
                name = 'lldb-debug',
                type = 'lldb',
                request = 'launch',
                program = function()
                    g_last_exe = vim.fn.input('Executable: ', g_last_exe, 'file')
                    return (vim.fn.getcwd() .. '/' .. g_last_exe)
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = function()
                    g_last_args = vim.fn.input('Args: ', g_last_args, 'file')
                    return { g_last_args }
                end,
            },
        }
        dap.configurations.c = dap.configurations.cpp
        vim.keymap.set('n', '<f9>', function() dap.continue() end, { desc = 'dap -> continue' })
        vim.keymap.set('n', '<s-f9>', function() dap.repl.toggle() end, { desc = 'dap -> repl' })
        vim.keymap.set('n', '<c-f9>', function() dap.toggle_breakpoint() end, { desc = 'dap -> breakpoint' })
        vim.keymap.set('n', '<f10>', function() dap.step_over() end, { desc = 'dap -> step over' })
        vim.keymap.set('n', '<f11>', function() dap.step_into() end, { desc = 'dap -> step into' })
        vim.keymap.set('n', '<s-f11>', function() dap.step_out() end, { desc = 'dap -> step out' })
    end
}
