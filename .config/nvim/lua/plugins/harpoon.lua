return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	opts = {
		menu = {
			width = vim.api.nvim_win_get_width(0) - 4,
		},
	},

	keys = {
		{
			"<leader>a",
			desc = "Add buffer to harpoon",
			function()
				require("harpoon"):list():add()
				vim.notify("Harpooned!", vim.log.levels.INFO)
			end,
		},
		{
			"<C-e>",
			desc = "Harpoon quick menu",
			function()
				require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
			end,
		},
		{
			"<leader>1",
			desc = "Select harpoon 1",
			function()
				require("harpoon"):list():select(1)
			end,
		},
		{
			"<leader>2",
			desc = "Select harpoon 2",
			function()
				require("harpoon"):list():select(2)
			end,
		},
		{
			"<leader>3",
			desc = "Select harpoon 3",
			function()
				require("harpoon"):list():select(3)
			end,
		},
		{
			"<leader>4",
			desc = "Select harpoon 4",
			function()
				require("harpoon"):list():select(4)
			end,
		},
		{
			"<leader>5",
			desc = "Select harpoon 5",
			function()
				require("harpoon"):list():select(5)
			end,
		},
	},
}
