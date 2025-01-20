return {
  'github/copilot.vim',

  vim.keymap.set('i', '<leader>cc', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false, description = 'Accept the current suggestion' }),
  copilot_no_tab_map = true,
  vim.keymap.set('i', '<leader>cd', '<Plug>(copilot-dismiss)', { description = 'Dismiss the current suggestion' }),
  vim.keymap.set('i', '<leader>cs', '<Plug>(copilot-suggest)', { description = 'Suggest a new completion' }),
  vim.keymap.set('i', '<leader>cn', '<Plug>(copilot-next)', { description = 'Go to the next suggestion' }),
  vim.keymap.set('i', '<leader>cp', '<Plug>(copilot-prev)', { description = 'Go to the previous suggestion' }),
  vim.keymap.set('i', '<leader>cl', '<Plug>(copilot-accept-line)', { description = 'Accept the current line' }),
  vim.keymap.set('i', '<leader>cw', '<Plug>(copilot-accept-word)', { description = 'Accept the current word' }),
}
