-- local sections = {
--   f = { desc = get_icon("Search", 1, true) .. "Find" },
--   p = { desc = get_icon("Package", 1, true) .. "Packages" },
--  l = { desc = get_icon("ActiveLSP", 1, true) .. "LSP" },
--   u = { desc = get_icon("Window", 1, true) .. "UI/UX" },
--   b = { desc = get_icon("Tab", 1, true) .. "Buffers" },
--   bs = { desc = get_icon("Sort", 1, true) .. "Sort Buffers" },
--   d = { desc = get_icon("Debugger", 1, true) .. "Debugger" },
--   g = { desc = get_icon("Git", 1, true) .. "Git" },
--   S = { desc = get_icon("Session", 1, true) .. "Session" },
--   t = { desc = get_icon("Terminal", 1, true) .. "Terminal" },
-- }

local function nmap(atalho, comando, opcoes)
  vim.api.nvim_set_keymap('n', atalho, comando, opcoes)
end

local function vmap(atalho, comando, opcoes)
  vim.api.nvim_set_keymap('v', atalho, comando, opcoes)
end

local function tmap(atalho, comando, opcoes)
  vim.api.nvim_set_keymap('t', atalho, comando, opcoes)
end

local M = {

  nmap('j', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = '[J]ump cursor down' }),
  nmap('k', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = '[K]ick cursor up' }),
  nmap('ç', 'l', { noremap = true, silent = true }), -- Set ç to movement
  nmap('l', 'h', { noremap = true, silent = true }), -- Set replace l to left
  nmap('<Leader>a', '<cmd>w<cr>', { desc = '[W]rite' }),
  nmap('<Leader>c', '<cmd>bd<cr>', { desc = '[C]lose' }),
  nmap('<Leader>q', '<cmd>confirm q<cr>', { desc = '[Q]uit' }),
  nmap('<Leader>n', '<cmd>enew<cr>', { desc = '[N]ew File' }),
  nmap('<C-s>', '<cmd>w!<cr>', { desc = 'Force Write' }),
  nmap('<C-q>', '<cmd>qa!<cr>', { desc = 'Force [Q]uit' }),
  nmap('|', '<cmd>vsplit<cr>', { desc = '[|] Quebra Vertical' }),
  nmap('\\', '<cmd>split<cr>', { desc = '[\\] Quebra Horizontal' }),

  -- Procurar arquivos
  -- nmap('<Leader>f', [[<Cmd>Explore<CR>]], { noremap = true, silent = true, desc = 'Arquivos' }),

  -- Plugin Manager
  nmap('<Leader>pi', '<cmd>:lua require("lazy").install()<cr>', { desc = '[P]lugins [I]nstall' }),
  nmap('<Leader>ph', '<cmd>:lua require("lazy").home()<cr>', { desc = '[P]lugins [H]ome' }),
  nmap('<Leader>ps', '<cmd>:lua require("lazy").sync()<cr>', { desc = '[P]lugins [S]ync' }),
  nmap('<Leader>pc', '<cmd>:lua require("lazy").check()<cr>', { desc = '[P]lugins [C]heck Update' }),
  nmap('<Leader>pu', '<cmd>:lua require("lazy").update()<cr>', { desc = '[P]lugins [U]pdate' }),

  -- Comments
  nmap('<leader>#', '<cmd>:lua require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)<cr>',
    { desc = 'Toggle comment line' }),
  vmap
  ('<leader>#', "<esc><cmd>:lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
    { desc = 'Toggle comment for selection' }),

  -- Git
  nmap('<Leader>gl', '<cmd>:LazyGit<cr>', { desc = '[G]it [L]azy' }),
  nmap(']g', '<cmd>:lua require("gitsigns").next_hunk()<cr>', { desc = 'Next [G]it hunk' }),
  nmap('[g', '<cmd>:lua require("gitsigns").prev_hunk()<cr>', { desc = 'Previous [G]it hunk' }),
  -- nmap('<Leader>gb', '<cmd>:lua require("gitsigns").blame_line()<cr>', { desc = 'View Git blame' }),
  nmap('<Leader>gB', '<cmd>:lua require("gitsigns").blame_line {full = true}<cr>', { desc = '[G]it [B]lame full' }),
  nmap('<Leader>gp', '<cmd>:lua require("gitsigns").preview_hunk()<cr>', { desc = '[G]it hunk [p]review' }),
  nmap('<Leader>gh', '<cmd>:lua require("gitsigns").reset_hunk()<cr>', { desc = '[G]it [h]unk Reset' }),
  nmap('<Leader>gr', '<cmd>:lua require("gitsigns").reset_buffer()<cr>', { desc = '[G]it buffer [r]eset' }),
  nmap('<Leader>gs', '<cmd>:lua require("gitsigns").stage_hunk()<cr>', { desc = '[G]it hunk [s]tage' }),
  nmap('<Leader>gS', '<cmd>:lua require("gitsigns").stage_buffer()<cr>', { desc = 'Git buffer [S]tage' }),
  nmap('<Leader>gu', '<cmd>:lua require("gitsigns").undo_stage_hunk()<cr>', { desc = '[G]it hunk [u]nstage' }),
  nmap('<Leader>gd', '<cmd>:lua require("gitsigns").diffthis()<cr>', { desc = 'View [G]it [d]iff' }),

  -- NeoTree
  mapN('<leader><Tab>', '<cmd>Neotree toggle right<cr>', { desc = 'Toggle Explorer' }),
  mapN('<Leader>e', '<cmd>Neotree toggle float<cr>', { desc = 'Toogle Float [E]xplorer' }),
  mapN(
    '<leader>o',
    '<cmd>:lua if vim.bo.filetype == "neo-tree" then vim.cmd.wincmd "p" else vim.cmd.Neotree "focus" end <cr>',
    { desc = 'Toggle Explorer Focus' }
  ),

  -- Package Manager
  nmap('<Leader>pm', '<cmd>Mason<cr>', { desc = '[M]ason Installer' }),
  nmap('<Leader>pM', '<cmd>MasonUpdate<cr>', { desc = '[M]ason Update' }),

  -- Terminal
  nmap('<Leader>tf', '<cmd>ToggleTerm direction=float<cr>', { desc = '[T]oggleTerm [F]loat' }),
  nmap('<Leader>th', '<cmd>ToggleTerm size=10 direction=horizontal<cr>', { desc = '[T]oggleTerm [H]orizontal Split' }),
  nmap('<Leader>tv', '<cmd>ToggleTerm size=60 direction=vertical<cr>', { desc = '[T]oggleTerm [V]ertical Split' }),

  -- Session Manager
  nmap('<leader>Sl', '<cmd>SessionManager! load_last_session<cr>', { desc = '[S]ession [l]oad last' }),
  nmap('<leader>Ss', '<cmd>SessionManager! save_current_session<cr>', { desc = '[S]ession [s]ave' }),
  nmap('<leader>Sd', '<cmd>SessionManager! delete_session<cr>', { desc = '[S]essions [d]elet' }),
  nmap('<leader>Sf', '<cmd>SessionManager! load_session<cr>', { desc = '[S]essions [f]ind' }),
  nmap('<leader>Sc', '<cmd>SessionManager! load_current_dir_session<cr>', { desc = '[S]ession Load [c]urrent' }),
}
return M
