return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>nt", "<cmd>Neotree toggle<cr>", desc = "Neotree" },
		{ "<leader>nb", "<cmd>Neotree buffers<cr>", desc = "Neotree buffers" },
	},
	opts = {
		close_if_last_window = false,
		popup_border_style = "rounded",
		enable_git_status = true,
		enable_diagnostics = true,
		enable_normal_mode_for_inputs = false,
		sort_case_insensitive = false,
		default_component_configs = {
			container = {
				enable_character_fade = true,
			},
			indent = {
				indent_size = 2,
				padding = 1,
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
				with_expanders = nil,
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
			icon = {
				folder_closed = ">",
				folder_open = "⌄",
				folder_empty = ">",
				default = " ",
				highlight = "NeoTreeFileIcon",
			},
			modified = {
				symbol = "[+]",
				highlight = "NeoTreeModified",
			},
			name = {
				trailing_slash = false,
				use_git_status_colors = true,
				highlight = "NeoTreeFileName",
			},
			git_status = {
				symbols = {
					added = "",
					modified = "",
					deleted = "✖",
					renamed = "R",
					untracked = "U",
					ignored = "I",
					unstaged = "☐",
					staged = "☑",
					conflict = "C",
				},
			},
			file_size = {
				enabled = true,
				required_width = 64,
			},
			type = {
				enabled = true,
				required_width = 122,
			},
			last_modified = {
				enabled = true,
				required_width = 88,
			},
			created = {
				enabled = true,
				required_width = 110,
			},
			symlink_target = {
				enabled = false,
			},
		},
		window = {
			position = "right",
			width = 40,
			mapping_options = {
				noremap = true,
				nowait = true,
			},
			mappings = {
				["<space>"] = {
					"toggle_node",
					nowait = false,
				},
				["<2-LeftMouse>"] = "open",
				["<cr>"] = "open",
				["<esc>"] = "cancel",
				["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
				["l"] = "focus_preview",
				["S"] = "open_split",
				-- ["s"] = "open_vsplit",
				["t"] = "open_tabnew",
				["w"] = "open_with_window_picker",
				["C"] = "close_node",
				["z"] = "close_all_nodes",
				["Z"] = "expand_all_nodes",
				["N"] = {
					"add",
					config = {
						show_path = "none",
					},
				},
				["A"] = "add_directory",
				["d"] = "delete",
				["r"] = "rename",
				["y"] = "copy_to_clipboard",
				["x"] = "cut_to_clipboard",
				["p"] = "paste_from_clipboard",
				["c"] = "copy",
				["m"] = "move",
				["q"] = "close_window",
				["R"] = "refresh",
				["?"] = "show_help",
				["<"] = "prev_source",
				[">"] = "next_source",
				["i"] = "show_file_details",
			},
		},
		nesting_rules = {},
		filesystem = {
			filtered_items = {
				visible = false,
				hide_dotfiles = true,
				hide_gitignored = false,
				hide_hidden = true,
			},
			follow_current_file = {
				enabled = true,
				leave_dirs_open = false,
			},
			group_empty_dirs = false,
			hijack_netrw_behavior = "open_current", -- netrw disabled, opening a directory opens neo-tree
			-- in whatever position is specified in window.position
			-- "open_current",  -- netrw disabled, opening a directory opens within the
			-- window like netrw would, regardless of window.position
			-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
			use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
			-- instead of relying on nvim autocmd events.
			window = {
				mappings = {
					["<bs>"] = "navigate_up",
					["."] = "set_root",
					["H"] = "toggle_hidden",
					["/"] = "fuzzy_finder",
					["D"] = "fuzzy_finder_directory",
					["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
					-- ["D"] = "fuzzy_sorter_directory",
					["f"] = "filter_on_submit",
					["<c-x>"] = "clear_filter",
					["[g"] = "prev_git_modified",
					["]g"] = "next_git_modified",
					["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
					["oc"] = { "order_by_created", nowait = false },
					["od"] = { "order_by_diagnostics", nowait = false },
					["og"] = { "order_by_git_status", nowait = false },
					["om"] = { "order_by_modified", nowait = false },
					["on"] = { "order_by_name", nowait = false },
					["os"] = { "order_by_size", nowait = false },
					["ot"] = { "order_by_type", nowait = false },
				},
				fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
					["<down>"] = "move_cursor_down",
					["<C-n>"] = "move_cursor_down",
					["<up>"] = "move_cursor_up",
					["<C-p>"] = "move_cursor_up",
				},
			},

			commands = {}, -- Add a custom command or override a global one using the same function name
		},
		buffers = {
			follow_current_file = {
				enabled = true, -- This will find and focus the file in the active buffer every time
				--              -- the current file is changed while the tree is open.
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			},
			group_empty_dirs = true, -- when true, empty folders will be grouped together
			show_unloaded = true,
			window = {
				mappings = {
					["bd"] = "buffer_delete",
					["<bs>"] = "navigate_up",
					["."] = "set_root",
					["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
					["oc"] = { "order_by_created", nowait = false },
					["od"] = { "order_by_diagnostics", nowait = false },
					["om"] = { "order_by_modified", nowait = false },
					["on"] = { "order_by_name", nowait = false },
					["os"] = { "order_by_size", nowait = false },
					["ot"] = { "order_by_type", nowait = false },
				},
			},
		},
	},
}
