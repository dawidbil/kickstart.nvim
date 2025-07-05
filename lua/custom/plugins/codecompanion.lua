return {
  'olimorris/codecompanion.nvim',
  opts = {},
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'j-hui/fidget.nvim',
  },
  config = function()
    require('codecompanion').setup {}
    vim.keymap.set({ 'n', 'v' }, '<leader>aa', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
    vim.keymap.set({ 'n', 'v' }, '<leader>at', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
    vim.keymap.set('v', '<leader>ad', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })
    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd [[cab cc CodeCompanion]]
  end,
  init = function()
    require('custom.plugins.codecompanion.fidget-spinner'):init()
  end,
}
