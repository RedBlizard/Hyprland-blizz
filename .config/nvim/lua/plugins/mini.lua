return {
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		version = false,
		config = function()
			require("mini.pairs").setup()
		end,
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"lazy",
					"mason",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
	{
		"echasnovski/mini.comment",
		keys = {
			{ "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
			{ "gcc", mode = "n", desc = "Comment toggle current line" },
			{ "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
		},
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		},
	},
	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		opts = function()
			local mouse_scrolled = false
			for _, scroll in ipairs({ "Up", "Down" }) do
				local key = "<ScrollWheel" .. scroll .. ">"
				vim.keymap.set({ "", "i" }, key, function()
					mouse_scrolled = true
					return key
				end, { expr = true })
			end

			local animate = require("mini.animate")
			return {
				resize = {
					timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
				},
				scroll = {
					timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
					subscroll = animate.gen_subscroll.equal({
						predicate = function(total_scroll)
							if mouse_scrolled then
								mouse_scrolled = false
								return false
							end
							return total_scroll > 1
						end,
					}),
				},
				open = {
					enable = false,
				},
				close = {
					enable = false,
				},
			}
		end,
	},
	{
		"echasnovski/mini.surround",
		keys = function(_, keys)
			local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local mappings = {
				{ opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
				{ opts.mappings.delete, desc = "Delete surrounding" },
				{ opts.mappings.find, desc = "Find right surrounding" },
				{ opts.mappings.find_left, desc = "Find left surrounding" },
				{ opts.mappings.highlight, desc = "Highlight surrounding" },
				{ opts.mappings.replace, desc = "Replace surrounding" },
				{ opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
			}
			mappings = vim.tbl_filter(function(m)
				return m[1] and #m[1] > 0
			end, mappings)
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		},
	},
	{
		"echasnovski/mini.bufremove",
		keys = {
			{
				"<leader>bd",
				function()
					local bd = require("mini.bufremove").delete
					if vim.bo.modified then
						local choice =
							vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
						if choice == 1 then
							vim.cmd.write()
							bd(0)
						elseif choice == 2 then
							bd(0, true)
						end
					else
						bd(0)
					end
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>bD",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Delete Buffer (Force)",
			},
		},
	},
	{
		"echasnovski/mini.files",
		opts = {
			windows = {
				preview = true,
				width_focus = 30,
				width_preview = 40,
			},
			options = {
				use_as_default_explorer = false,
			},
		},
		keys = {
			{
				"<leader>=",
				function()
					require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
				end,
				desc = "Open mini.files (Directory of Current File)",
			},
			{
				"<leader>+",
				function()
					require("mini.files").open(vim.uv.cwd(), true)
				end,
				desc = "Open mini.files (cwd)",
			},
		},
		config = function(_, opts)
			require("mini.files").setup(opts)

			local show_dotfiles = true

			local filter_show = function(fs_entry)
				return true
			end
			local filter_hide = function(fs_entry)
				return not vim.startswith(fs_entry.name, ".")
			end

			local toggle_dotfiles = function()
				show_dotfiles = not show_dotfiles
				local new_filter = show_dotfiles and filter_show or filter_hide
				require("mini.files").refresh({ content = { filter = new_filter } })
			end

			local map_split = function(buf_id, lhs, direction, close_on_file)
				local rhs = function()
					local new_target_window
					local cur_target_window = require("mini.files").get_target_window()
					if cur_target_window ~= nil then
						vim.api.nvim_win_call(cur_target_window, function()
							vim.cmd("belowright " .. direction .. " split")
							new_target_window = vim.api.nvim_get_current_win()
						end)

						require("mini.files").set_target_window(new_target_window)
						require("mini.files").go_in({ close_on_file = close_on_file })
					end
				end

				local desc = "Open in " .. direction .. " split"
				if close_on_file then
					desc = desc .. " and close"
				end
				vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
			end

			local files_set_cwd = function()
				local cur_entry_path = require("mini.files").get_current_entry_path()
				local cur_directory = vim.fs.dirname(cur_entry_path)
				if cur_directory ~= nil then
					vim.fn.chdir(cur_directory)
				end
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local buf_id = args.data.buf_id

					vim.keymap.set(
						"n",
						opts.mappings and opts.mappings.toggle_hidden or "g.",
						toggle_dotfiles,
						{ buffer = buf_id, desc = "Toggle hidden files" }
					)

					vim.keymap.set(
						"n",
						opts.mappings and opts.mappings.change_cwd or "gc",
						files_set_cwd,
						{ buffer = args.data.buf_id, desc = "Set cwd" }
					)

					map_split(buf_id, opts.mappings and opts.mappings.go_in_horizontal or "<C-w>s", "horizontal", false)
					map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical or "<C-w>v", "vertical", false)
					map_split(
						buf_id,
						opts.mappings and opts.mappings.go_in_horizontal_plus or "<C-w>S",
						"horizontal",
						true
					)
					map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical_plus or "<C-w>V", "vertical", true)
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesActionRename",
				callback = function(event)
					local changes = {
						files = {
							{
								oldUri = vim.uri_from_fname(event.data.from),
								newUri = vim.uri_from_fname(event.data.to),
							},
						},
					}

					local clients = vim.lsp.get_clients and vim.lsp.get_clients() or vim.lsp.get_clients()
					for _, client in ipairs(clients) do
						if client.supports_method("workspace/willRenameFiles") then
							local resp = client.request_sync("workspace/willRenameFiles", changes, 1000, 0)
							if resp and resp.result ~= nil then
								vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
							end
						end
						if client.supports_method("workspace/didRenameFiles") then
							client.notify("workspace/didRenameFiles", changes)
						end
					end
				end,
			})
		end,
	},
	{
		"echasnovski/mini.starter",
		version = false,
		lazy = true,
		event = "VimEnter",
		opts = function()
			local logo = [[
     ▄▄▄▄    ██▓    ▄▄▄       ▄████▄   ██ ▄█▀ ███▄ ▄███▓ ▄▄▄        ▄████ ▓█████
    ▓█████▄ ▓██▒   ▒████▄    ▒██▀ ▀█   ██▄█▒ ▓██▒▀█▀ ██▒▒████▄     ██▒ ▀█▒▓█   ▀
    ▒██▒ ▄██▒██░   ▒██  ▀█▄  ▒▓█    ▄ ▓███▄░ ▓██    ▓██░▒██  ▀█▄  ▒██░▄▄▄░▒███
    ▒██░█▀  ▒██░   ░██▄▄▄▄██ ▒▓▓▄ ▄██▒▓██ █▄ ▒██    ▒██ ░██▄▄▄▄██ ░▓█  ██▓▒▓█  ▄
    ░▓█  ▀█▓░██████▒▓█   ▓██▒▒ ▓███▀ ░▒██▒ █▄▒██▒   ░██▒ ▓█   ▓██▒░▒▓███▀▒░▒████▒
    ░▒▓███▀▒░ ▒░▓  ░▒▒   ▓▒█░░ ░▒ ▒  ░▒ ▒▒ ▓▒░ ▒░   ░  ░ ▒▒   ▓▒█░ ░▒   ▒ ░░ ▒░ ░
    ▒░▒   ░ ░ ░ ▒  ░ ▒   ▒▒ ░  ░  ▒   ░ ░▒ ▒░░  ░      ░  ▒   ▒▒ ░  ░   ░  ░ ░  ░
     ░    ░   ░ ░    ░   ▒   ░        ░ ░░ ░ ░      ░     ░   ▒   ░ ░   ░    ░
     ░          ░  ░     ░  ░░ ░      ░  ░          ░         ░  ░      ░    ░  ░
          ░                  ░
    ]]
			local starter = require("mini.starter")
			local config = {
				evaluate_single = true,
				header = logo,
				items = {
					{ name = "Find File", action = ":Telescope find_files", section = "Telescope" },
					{ name = "Grep Text", action = ":Telescope live_grep", section = "Telescope" },
					{ name = "Recent Files", action = ":Telescope oldfiles", section = "Telescope" },
					starter.sections.recent_files(5, false),
					{ name = "Lazy", action = ":Lazy", section = "Lazy" },
					{ name = "New File", action = ":ene | startinsert", section = "Built-in" },
					{ name = "Quit", action = ":qa", section = "Built-in" },
				},
				content_hooks = {
					starter.gen_hook.adding_bullet("░ "),
					starter.gen_hook.indexing("all", { "Telescope", "Recent files", "Lazy", "Built-in" }),
					starter.gen_hook.aligning("center", "center"),
					starter.gen_hook.padding(0, 1),
				},
				query_updaters = [[abcdefghijklmnopqrstuvwxyz0123456789_-.]],
				footer = "",
			}
			return config
		end,
		config = function(_, config)
			local starter = require("mini.starter")
			starter.setup(config)
		end,
	},
}
