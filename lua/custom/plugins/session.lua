return { -- NOTE: Session Manager
  'Shatur/neovim-session-manager',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local Path = require 'plenary.path'
    local config = require 'session_manager.config'

    require('session_manager').setup {
      -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
      autoload_mode = config.AutoloadMode.Disabled,
      autosave_last_session = true, -- Automatically save last session on exit and on session switch.
      autosave_only_in_session = true, -- Always autosaves session. If true, only autosaves after a session is active.
    }
  end,
}
