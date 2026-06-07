return {
  'j-hui/fidget.nvim',
  commit = '4ec7bed',
  opts = {
    -- Less intrusive toasts
    notification = {
      window = { winblend = 0, zindex = 60 },
      view = { stack_upwards = false },
    },
    -- Lean progress UI (LSP + our CodeCompanion hooks)
    progress = {
      display = {
        progress_icon = { pattern = 'dots', period = 1 },
        done_icon = '✔',
        group_style = 'compact',
      },
      lsp = { progress_ringbuf_size = 128 },
    },
  },
}
