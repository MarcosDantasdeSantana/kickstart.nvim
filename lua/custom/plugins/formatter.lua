return { -- NOTE: Formater: Conform.nvim
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'

    conform.setup {
      formatters_by_ft = {
        javascript = { 'ast-grep' },
        typescript = { 'ast-grep' },
        javascriptreact = { 'ast-grep' },
        typescriptreact = { 'ast-grep' },
        css = { 'ast-grep' },
        html = { 'ast-grep' },
        json = { 'ast-grep' },
        markdown = { 'ast-grep' },
        lua = { 'stylua' },
        python = { 'isort', 'black' },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    }
    vim.keymap.set({ 'n', 'v' }, '<leader>df', function()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      }
    end, { desc = '[F]ormat File' })
  end,
}
