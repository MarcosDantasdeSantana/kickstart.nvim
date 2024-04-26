return { -- NOTE: Menu inicial
  'goolord/alpha-nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'
    dashboard.section.header.val = {
      [[    ███╗   ███╗ █████╗ ██╗  ██╗███████╗   ]],
      [[    ████╗ ████║██╔══██╗██║ ██╔╝██╔════╝   ]],
      [[    ██╔████╔██║███████║█████╔╝ █████╗     ]],
      [[    ██║╚██╔╝██║██╔══██║██╔═██╗ ██╔══╝     ]],
      [[    ██║ ╚═╝ ██║██║  ██║██║  ██╗███████╗   ]],
      [[    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ]],
      [[      ██████╗ ██████╗  ██████╗ ██╗        ]],
      [[     ██╔════╝██╔═══██╗██╔═══██╗██║        ]],
      [[     ██║     ██║   ██║██║   ██║██║        ]],
      [[     ██║     ██║   ██║██║   ██║██║        ]],
      [[     ╚██████╗╚██████╔╝╚██████╔╝███████╗   ]],
      [[      ╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝   ]],
      [[███████╗████████╗██╗   ██╗███████╗███████╗]],
      [[██╔════╝╚══██╔══╝██║   ██║██╔════╝██╔════╝]],
      [[███████╗   ██║   ██║   ██║█████╗  █████╗  ]],
      [[╚════██║   ██║   ██║   ██║██╔══╝  ██╔══╝  ]],
      [[███████║   ██║   ╚██████╔╝██║     ██║     ]],
      [[╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝     ]],
    }
    dashboard.section.buttons.val = {
      dashboard.button('f', ' ' .. ' Find file', ':Telescope find_files <CR>'),
      dashboard.button('n', ' ' .. ' New file', ':ene <BAR> startinsert <CR>'),
      dashboard.button('r', ' ' .. ' Recent files', ':Telescope oldfiles <CR>'),
      dashboard.button('g', ' ' .. ' Find text', ':Telescope live_grep <CR>'),
      dashboard.button('c', ' ' .. ' Config', ':e $MYVIMRC <CR>'),
      dashboard.button('s', ' ' .. ' Restore Session', ':SessionManager load_last_session<CR>'),
      dashboard.button('l', '󰒲 ' .. ' Lazy', ':Lazy<CR>'),
    }
    local handle = io.popen 'fortune'
    local fortune = handle:read '*a'
    handle:close()
    dashboard.section.footer.val = fortune

    dashboard.config.opts.noautocmd = true
    alpha.setup(dashboard.config)
  end,
}
