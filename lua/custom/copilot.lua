return {
  'github/copilot.vim',

  vim.keymap.set('i', '<leader>cc', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false, desc = 'Accept the current suggestion' }),
  copilot_no_tab_map = true,
  vim.keymap.set('i', '<leader>cd', '<Plug>(copilot-dismiss)', { desc = 'Dismiss the current suggestion' }),
  vim.keymap.set('i', '<leader>cs', '<Plug>(copilot-suggest)', { desc = 'Suggest a new completion' }),
  vim.keymap.set('i', '<leader>cn', '<Plug>(copilot-next)', { desc = 'Go to the next suggestion' }),
  vim.keymap.set('i', '<leader>cp', '<Plug>(copilot-prev)', { desc = 'Go to the previous suggestion' }),
  vim.keymap.set('i', '<leader>cl', '<Plug>(copilot-accept-line)', { desc = 'Accept the current line' }),
  vim.keymap.set('i', '<leader>cw', '<Plug>(copilot-accept-word)', { desc = 'Accept the current word' }),
}
