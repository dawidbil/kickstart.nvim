-- Open OpenGL reference on currect word in browser
vim.keymap.set('n', '<leader>gl', function()
  require('custom.functions').opengl(vim.fn.expand '<cword>')
end, { desc = 'Open OpenGL reference on currect word in browser' })

vim.api.nvim_create_user_command('Opengl', function(opts)
  require('custom.functions').opengl(opts.fargs[1])
end, { nargs = 1, desc = 'Open OpenGL reference on currect word in browser' })

-- Hide diagnostics for a current buffer
vim.keymap.set('n', '<leader>xb', '<cmd>lua vim.diagnostic.hide(nil, 0)<cr>', { desc = 'Hide diagnostics in buffer' })

-- Show diagnostics in floating window
vim.keymap.set('n', '<leader>xd', vim.diagnostic.open_float, { desc = 'Show diagnostics in floating window' })
