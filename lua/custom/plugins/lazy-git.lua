return { -- NOTE: Lazy Git
  'kdheepak/lazygit.nvim',
  event = 'BufEnter',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('telescope').load_extension('lazygit')
  end,
}
