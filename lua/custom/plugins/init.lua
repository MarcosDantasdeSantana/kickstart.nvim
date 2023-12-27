-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

	{ -- NOTE: Menu inicial
		'goolord/alpha-nvim',
		event = 'VimEnter',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require 'alpha'.setup(require 'alpha.themes.startify'.config)
		end,
	},

	{ -- NOTE: Theme catppuccin padrão
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 1000,
		config = function()
			vim.cmd.colorscheme 'catppuccin'
		end,
	},

	{ -- NOTE: Tabs
		'romgrk/barbar.nvim',
		event = 'VeryLazy',
		dependencies = {
			'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
			'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
		},
		init = function() vim.g.barbar_auto_setup = false end,
		opts = {
			-- lazy.nvim will automatically call setup for you.
		},
		version = '^1.0.0', -- optional: only update when a new 1.x version is released
	},

	{ -- NOTE: Edit statusline
		'nvim-lualine/lualine.nvim',
		event = 'VeryLazy',
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = true,
				theme = 'catppuccin',
			},
		},
	},

	{ -- NOTE: Edit which-key
		"folke/which-key.nvim",
		opts = {
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "", -- symbol used between a key and it's label
				group = "", -- symbol prepended to a group
			},
		}
	},

	{ -- NOTE: Auto Pairs
		"windwp/nvim-autopairs",
		-- Optional dependency
		dependencies = { 'hrsh7th/nvim-cmp' },
		config = function()
			require("nvim-autopairs").setup {}
			-- If you want to automatically add `(` after selecting a function or method
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			local cmp = require('cmp')
			cmp.event:on(
				'confirm_done',
				cmp_autopairs.on_confirm_done()
			)
		end,
	},

	{ -- NOTE: Terminal
		'akinsho/toggleterm.nvim',
		version = "*",
		opts = {
			size = 10,
			open_mapping = [[<F7>]],
			shading_factor = 2,
			direction = "float",
			float_opts = {
				border = "curved",
				highlights = { border = "Normal", background = "Normal" },
			},
		},
	},

	{ -- NOTE: Fold look modern and keep high performance.
		'kevinhwang91/nvim-ufo',
		dependencies = 'kevinhwang91/promise-async',
		opts = {
			provider_selector = function(bufnr, filetype, buftype)
				return { 'treesitter', 'indent' }
			end,
		},
	},

	{ -- NOTE: Arquivos
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		opts = {
			auto_clean_after_session_restore = true,
			close_if_last_window = true,
			source_selector = {
				winbar = true,
				content_layout = "center",
				sources = {
					{ source = "filesystem", display_name = " File" },
					{ source = "buffers", display_name = "󰕸 Bufs" },
					{ source = "git_status", display_name = "󰊢 Git" },
					{ source = "diagnostics", display_name = " Diagnostic" },
				},
			},
			default_component_configs = {
				indent = { padding = 0, indent_size = 1 },
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "",
					default = "",
				},
				modified = { symbol = "" },
				git_status = {
					symbols = {
						added = "",
						deleted = "",
						modified = "",
						renamed = "",
						untracked = "",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "󱚠",
					},
				},
			},
			commands = {
				system_open = function(state) -- BUG:
					local node = state.tree:get_node()
					local path = node:get_id()
					-- Windows: open file in default application
					vim.fn.jobstart({ path }, { detach = true })
					-- macOs: open file in default application in the background.
					vim.fn.jobstart({ 'xdg-open', '-g', path }, { detach = true })
					-- Linux: open file in default application
					vim.fn.jobstart({ 'xdg-open', path }, { detach = true })
				end,
				parent_or_close = function(state)
					local node = state.tree:get_node()
					if (node.type == "directory" or node:has_children()) and node:is_expanded() then
						state.commands.toggle_node(state)
					else
						require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
					end
				end,
				child_or_open = function(state)
					local node = state.tree:get_node()
					if node.type == "directory" or node:has_children() then
						if not node:is_expanded() then -- if unexpanded, expand
							state.commands.toggle_node(state)
						else -- if expanded and has children, seleect the next child
							require("neo-tree.ui.renderer").focus_node(state,
								node:get_child_ids()[1])
						end
					else -- if not a directory just open it
						state.commands.open(state)
					end
				end,
				copy_selector = function(state)
					local node = state.tree:get_node()
					local filepath = node:get_id()
					local filename = node.name
					local modify = vim.fn.fnamemodify

					local results = {
						e = { val = modify(filename, ":e"), msg = "Extension only" },
						f = { val = filename, msg = "Filename" },
						F = { val = modify(filename, ":r"), msg = "Filename w/o extension" },
						h = { val = modify(filepath, ":~"), msg = "Path relative to Home" },
						p = { val = modify(filepath, ":."), msg = "Path relative to CWD" },
						P = { val = filepath, msg = "Absolute path" },
					}

					local messages = {
						{ "\nChoose to copy to clipboard:\n", "Normal" },
					}
					for i, result in pairs(results) do
						if result.val and result.val ~= "" then
							vim.list_extend(messages, {
								{ ("%s."):format(i),           "Identifier" },
								{ (" %s: "):format(result.msg) },
								{ result.val,                  "String" },
								{ "\n" },
							})
						end
					end
					vim.api.nvim_echo(messages, false, {})
					local result = results[vim.fn.getcharstr()]
					if result and result.val and result.val ~= "" then
						vim.notify("Copied: " .. result.val)
						vim.fn.setreg("+", result.val)
					end
				end,
			},
			window = {
				width = 30,
				mappings = {
					["<space>"] = false, -- disable space until we figure out which-key disabling
					["[b"] = "prev_source",
					["]b"] = "next_source",
					o = "open",
					O = "system_open",
					h = "parent_or_close",
					l = "child_or_open",
					Y = "copy_selector",
				},
			},
			filesystem = {
				follow_current_file = { enabled = true },
				hijack_netrw_behavior = "open_current",
				use_libuv_file_watcher = true,
			},
			event_handlers = {
				{
					event = "neo_tree_buffer_enter",
					handler = function(_) vim.opt_local.signcolumn = "auto" end,
				},
			},
		},
	},

	-- { -- NOTE: Session Manager
	--   "Shatur/neovim-session-manager",
	-- },

	{ -- NOTE: Lazy Git
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim"
		},
		config = function()
			require("telescope").load_extension("lazygit")
		end,
	},

	{ -- NOTE: Aparencia do imput e seletor
		"stevearc/dressing.nvim",
	},

	{ -- NOTE: Highliters NOTE TODO BUG
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	{ -- NOTE: Notificação
		"rcarriga/nvim-notify",
		opts = function()
			vim.notify = require("notify")
		end,
	},
}
