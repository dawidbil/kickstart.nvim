return {
  'Vigemus/iron.nvim',
  config = function()
    local iron = require 'iron.core'
    local leader = '<space>'
    iron.setup {
      config = {
        scratch_repl = true,
        repl_definition = {
          python = {
            command = { 'ipython', '--no-autoindent' },
            format = require('iron.fts.common').bracketed_paste_python,
            block_dividers = { '```python', '```' },
          },
          markdown = {
            command = { 'ipython', '--no-autoindent' },
            format = require('iron.fts.common').bracketed_paste_python,
            block_dividers = { '```python', '```' },
          },
          sh = {
            command = { 'zsh' },
          },
        },
        repl_open_cmd = require('iron.view').split.horizontal.botright(15),
      },
      keymaps = {
        toggle_repl = leader .. 'ir',
        restart_repl = leader .. 'iR',
        send_motion = leader .. 'ic',
        visual_send = leader .. 'ic',
        send_line = leader .. 'il',
        cr = leader .. 'i<cr>',
        send_code_block = leader .. 'ib',
        send_code_block_and_move = leader .. 'im',
      },
    }
  end,
}
