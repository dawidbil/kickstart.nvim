return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'j-hui/fidget.nvim',
  },
  config = function()
    require('codecompanion').setup {
      adapters = {
        perplexity = function()
          return require 'custom.plugins.codecompanion.perplexity'
        end,
      },
      display = {
        chat = {
          icons = {
            buffer_pin = ' ',
            buffer_watch = '👀 ',
          },
        },
      },
      strategies = {
        chat = {
          keymaps = {
            clear = {
              modes = { n = 'gtx' },
            },
          },
        },
      },
    }
    vim.keymap.set({ 'n', 'v' }, '<leader>aa', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
    vim.keymap.set({ 'n', 'v' }, '<leader>at', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
    vim.keymap.set('v', '<leader>ad', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })
    vim.cmd [[cab cc CodeCompanion]]
    vim.cmd [[cab ccc CodeCompanionChat]]
  end,
  init = function()
    require('custom.plugins.codecompanion.fidget-spinner'):init()
  end,
}
