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

function mapN(atalho, comando, opcoes)
    vim.api.nvim_set_keymap('n', atalho, comando, opcoes)
end

function mapV(atalho, comando, opcoes)
    vim.api.nvim_set_keymap('v', atalho, comando, opcoes)
end

function mapT(atalho, comando, opcoes)
    vim.api.nvim_set_keymap('t', atalho, comando, opcoes)
end

local M = {

    mapN('j', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "[J]ump cursor down" }),
    mapN('k', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "[K]ick cursor up" }),
    mapN('ç', 'l', { noremap = true, silent = true }), -- Set ç to movement
    mapN('l', 'h', { noremap = true, silent = true }), -- Set replace l to left
    mapT('ç', 'l', { noremap = true, silent = true }), -- Set ç to movement in terminal
    mapT('l', 'h', { noremap = true, silent = true }), -- Set replace l to left in terminal
    mapN('<Leader>a', '<cmd>w<cr>', { desc = '[W]rite' }),
    mapN('<Leader>c', '<cmd>bd<cr>', { desc = '[C]lose' }),
    mapN('<Leader>q', '<cmd>confirm q<cr>', { desc = '[Q]uit' }),
    mapN('<Leader>n', '<cmd>enew<cr>', { desc = '[N]ew File' }),
    mapN('<C-s>', '<cmd>w!<cr>', { desc = 'Force Write' }),
    mapN('<C-q>', '<cmd>qa!<cr>', { desc = 'Force [Q]uit' }),
    mapN('|', '<cmd>vsplit<cr>', { desc = '[|] Quebra Vertical' }),
    mapN('\\', '<cmd>split<cr>', { desc = '[\\] Quebra Horizontal' }),


    -- Procurar arquivos
    mapN('<Leader><Tab>', [[<Cmd>Explore<CR>]],
        { noremap = true, silent = true, desc = 'Arquivos' }),


    -- Plugin Manager
    mapN('<Leader>pi', '<cmd>:lua require("lazy").install()<cr>', { desc = '[P]lugins [I]nstall' }),
    mapN('<Leader>ph', '<cmd>:lua require("lazy").home()<cr>', { desc = '[P]lugins [H]ome' }),
    mapN('<Leader>ps', '<cmd>:lua require("lazy").sync()<cr>', { desc = '[P]lugins [S]ync' }),
    mapN('<Leader>ps', '<cmd>:lua require("lazy").home()<cr>', { desc = '[P]lugins [H]ome' }),
    mapN('<Leader>pc', '<cmd>:lua require("lazy").check()<cr>', { desc = '[P]lugins [C]heck Update' }),
    mapN('<Leader>pu', '<cmd>:lua require("lazy").update()<cr>', { desc = '[P]lugins [U]pdate' }),


    -- Tabs
    mapN(']t', '<cmd>tabnext<cr>', { desc = 'Next Tab' }),
    mapN('[t', '<cmd>tabprevious<cr>', { desc = 'Previous tab' }),


    -- Comments
    mapN('<leader>#', '<cmd>:lua require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)<cr>',
        { desc = "Toggle comment line" }),
    mapV('<leader>#', "<esc><cmd>:lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
        { desc = "Toggle comment for selection" }),


    -- Git
    mapN(']g', '<cmd>:lua require("gitsigns").next_hunk()<cr>', { desc = 'Next Git hunk' }),
    mapN('[g', '<cmd>:lua require("gitsigns").prev_hunk()<cr>', { desc = 'Previous Git hunk' }),
    mapN('<Leader>gg', '<cmd>:LazyGit<cr>', { desc = 'LazyGit' }),
    mapN('<Leader>gl', '<cmd>:lua require("gitsigns").blame_line()<cr>', { desc = 'View Git blame' }),
    mapN('<Leader>gL', '<cmd>:lua require("gitsigns").blame_line {full = true}<cr>', { desc = 'View full Git blame' }),
    mapN('<Leader>gl', '<cmd>:lua require("gitsigns").preview_hunk()<cr>', { desc = 'Preview Git hunk' }),
    mapN('<Leader>gh', '<cmd>:lua require("gitsigns").reset_hunk()<cr>', { desc = 'Reset Git hunk' }),
    mapN('<Leader>gr', '<cmd>:lua require("gitsigns").reset_buffer()<cr>', { desc = 'Reset Git buffer' }),
    mapN('<Leader>gs', '<cmd>:lua require("gitsigns").stage_hunk()<cr>', { desc = 'Stage Git hunk' }),
    mapN('<Leader>gS', '<cmd>:lua require("gitsigns").stage_buffer()<cr>', { desc = 'Stage Git buffer' }),
    mapN('<Leader>gu', '<cmd>:lua require("gitsigns").undo_stage_hunk()<cr>', { desc = 'Unstage Git hunk' }),
    mapN('<Leader>gd', '<cmd>:lua require("gitsigns").diffthis()<cr>', { desc = 'View Git diff' }),

    -- NeoTree
    mapN('<leader>e', '<cmd>Neotree toggle<cr>', { desc = "Toggle [E]xplorer" }),
    mapN("<leader>o",
        '<cmd>:lua if vim.bo.filetype == "neo-tree" then vim.cmd.wincmd "p" else vim.cmd.Neotree "focus" end <cr>',
        { desc = "Toggle Explorer Focus" }),


    -- Package Manager
    mapN('<Leader>pm', '<cmd>Mason<cr>', { desc = '[M]ason Installer' }),
    mapN('<Leader>pM', '<cmd>MasonUpdateAll<cr>', { desc = '[M]ason Update' }),


    -- Terminal
    mapN('<Leader>tf', "<cmd>ToggleTerm direction=float<cr>", { desc = "[T]oggleTerm [F]loat" }),
    mapN('<Leader>th', "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "[T]oggleTerm [H]orizontal Split" }),
    mapN('<Leader>tv', "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "[T]oggleTerm [V]ertical Split" }),


    -- Session Manager
    mapN("<leader>Sl", "<cmd>SessionManager! load_last_session<cr>", { desc = "Load last session" }),
    mapN("<leader>Ss", "<cmd>SessionManager! save_current_session<cr>", { desc = "Save this session" }),
    mapN("<leader>Sd", "<cmd>SessionManager! delete_session<cr>", { desc = "Delete session" }),
    mapN("<leader>Sf", "<cmd>SessionManager! load_session<cr>", { desc = "Search sessions" }),
    mapN("<leader>S.", "<cmd>SessionManager! load_current_dir_session<cr>", { desc = "Load current directory session" }),

    -- UI/UX
    --  Custom menu for modification of the user experience
    -- mapN('<Leader>ua', ui.toggle_autopairs, { desc = 'Toggle Autopairs' }),
    -- mapN('<Leader>ub', ui.toggle_background, { desc = 'Toggle Background' }),
    -- mapN('<Leader>uc', ui.toggle_cmp, { desc = 'Toggle Autocompletion' }),
    -- mapN('<Leader>uC', '<cmd>ColorizerToggle<cr>', { desc = 'Toggle Color Highlight' }),
    -- mapN('<Leader>ud', ui.toggle_diagnostics, { desc = 'Toggle Diagnostics' }),
    -- mapN('<Leader>ug', ui.toggle_signcolumn, { desc = 'Toggle Signcolumn' }),
    -- mapN('<Leader>ui', ui.set_indent, { desc = 'Change Indent Setting' }),
    -- mapN('<Leader>ul', ui.toggle_statusline, { desc = 'Toggle StatusLine' }),
    -- mapN('<Leader>uL', ui.toggle_codelens, { desc = 'Toggle CodeLens' }),
    -- mapN('<Leader>un', ui.change_number, { desc = 'Change Line Numbering' }),
    -- mapN('<Leader>uN', ui.toggle_ui_notifications, { desc = 'Toggle Notifications' }),
    -- mapN('<Leader>up', ui.toggle_paste, { desc = 'Toggle Paste Mode' }),
    -- mapN('<Leader>us', ui.toggle_spell, { desc = 'Toggle Spellcheck' }),
    -- mapN('<Leader>uS', ui.toggle_conceal, { desc = 'Toggle Conceal' }),
    -- mapN('<Leader>ut', ui.toggle_tabline, { desc = 'Toggle Tabline' }),
    -- mapN('<Leader>uu', ui.toggle_url_match, { desc = 'Toggle URL Highlight' }),
    -- mapN('<Leader>uw', ui.toggle_wrap, { desc = 'Toggle Wrap' }),
    -- mapN('<Leader>uy', ui.toggle_syntax, { desc = 'Toggle Syntax Highlight' }),
    -- mapN('<Leader>uh', ui.toggle_foldcolumn, { desc = 'Toggle Foldcolumn' }),

}
return M
