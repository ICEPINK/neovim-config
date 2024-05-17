vim.cmd.language('en')
vim.api.nvim_create_autocmd({ 'Filetype' }, {
  desc = 'Commenting for c, c++',
  pattern = {'cpp', 'hpp'},
  callback = function(event)
    vim.bo[event.buf].commentstring = '// %s'
  end,
})
