return { -- NOTE: Edit statusline
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = true,
      theme = 'catppuccin',
    },
  },
}
