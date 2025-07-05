return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  opts = {
    filetypes = {
      ['*'] = false,
      python = true,
      lua = true,
      markdown = true,
    },
  },
  config = function(_, opts)
    require('copilot').setup(opts)
    local suggestion = require 'copilot.suggestion'
    vim.keymap.set('n', '<leader>ce', function()
      suggestion.toggle_auto_trigger()
    end, { desc = 'Toggle auto trigger for suggestions' })
    vim.keymap.set('i', '<leader>ca', function()
      suggestion.next()
    end, { desc = 'Ask for a next suggestion' })
    vim.keymap.set('i', '<leader>cp', function()
      suggestion.prev()
    end, { desc = 'Ask for a previous suggestion' })
    vim.keymap.set('i', '<leader>cc', function()
      suggestion.accept()
    end, { desc = 'Accept the current suggestion' })
    vim.keymap.set('i', '<leader>cl', function()
      suggestion.accept_line()
    end, { desc = 'Accept the current suggestion and move to the next line' })
    vim.keymap.set('i', '<leader>cd', function()
      suggestion.dismiss()
    end, { desc = 'Dismiss the current suggestion' })
  end,
  should_attach = function(_, bufname)
    if string.match(bufname, 'env') then
      return false
    end
    return true
  end,
}
