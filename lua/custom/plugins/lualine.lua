return { -- NOTE: Edit statusline
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- See `:help lualine.txt`
  opts = {
    options = {
      theme = 'catppuccin',
      icons_enabled = true,
    },
  },
}
