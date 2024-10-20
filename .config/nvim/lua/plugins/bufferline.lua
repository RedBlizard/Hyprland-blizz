return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	keys = {
		{ "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next bufffer" },
		{ "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
	},
	opts = {
		options = {
			close_command = function(n)
				require("mini.bufremove").delete(n, false)
			end,
			right_mouse_command = function(n)
				require("mini.bufremove").delete(n, false)
			end,
			offsets = {
				{
					filetype = "neo-tree",
					text = "Neo-tree",
					highlight = "Directory",
					text_align = "left",
				},
			},
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				local icon = level:match("error") and " " or " "
				return " " .. icon .. count
			end,
			mode = "tabs",
			always_show_bufferline = false,
			show_buffer_close_icons = false,
			show_close_icon = false,
			color_icons = true,
		},
	},
}
