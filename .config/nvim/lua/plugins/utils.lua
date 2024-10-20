return {
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TodoLocList", "TodoTelescope", "TodoQuickFix", "TodoTrouble" },
		opts = {
			signs = true,
			sign_priority = 8,
			keywords = {
				FIX = {
					icon = " ",
					color = "error",
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
				},
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = "󰥔 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = "󱞁 ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
		},
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		keys = {
			{
				"<leader>on",
				function()
					vim.api.nvim_command("ObsidianNew")
					vim.api.nvim_buf_set_lines(0, 0, -1, false, {})
				end,
				desc = "Create new note",
			},
			{ "<leader>oo", "<cmd>ObsidianSearch<cr>", desc = "Search notes (Obsidian)" },
			{ "<leader>os", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick Switch (Obsidian)" },
			{ "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Show location list of backlinks (Obsidian)" },
			{ "<leader>of", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link under cursor (Obsidian)" },
			{ "<leader>ot", "<cmd>ObsidianTemplate<cr>", desc = "Apply Template (Obsidian)" },
			{ "<leader>og", "<cmd>ObsidianGitSync<cr>", desc = "Sync changes to git (Obsidian)" },
		},
		opts = {
			workspaces = {
				{
					name = "Obsidian Vault",
					path = "~/Documents/Obsidian Vault/",
				},
			},
			completion = {
				nvim_cmp = true,
				min_chars = 2,
			},
			attachment = {
				img_folder = "/Files",
			},
			new_notes_location = "current_dir",
			disable_frontmatter = true,
			templates = {
				subdir = "99 - Meta/01 - Templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M:%S",
			},
		},
	},
}
