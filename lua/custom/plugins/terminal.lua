return { -- NOTE: Terminal
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    size = 10,
    open_mapping = [[<F7>]],
    shading_factor = 2,
    direction = 'float',
    float_opts = {
      border = 'curved',
      highlights = { border = 'Normal', background = 'Normal' },
    },
  },
}
