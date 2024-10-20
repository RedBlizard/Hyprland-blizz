return {
	"tamton-aquib/staline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		sections = {
			left = { "  ", "mode", " ", "branch", " " },
			mid = { "file_name" },
			right = { "lsp", "  ", "line_column" },
		},
		mode_colors = {
			i = "#a6e3a1",
			n = "#89b4fa",
			c = "#fab387",
			v = "#cba6f7",
		},
		defaults = {
			true_colors = true,
			line_column = " [%l/%L] :%c  ",
			branch_symbol = " ",
		},
	},
}
