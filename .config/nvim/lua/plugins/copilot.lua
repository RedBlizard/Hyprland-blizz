return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	build = ":Copilot auth",
	opts = {
		suggestion = {
			accept = false,
			enabled = true,
			auto_trigger = true,
		},
		panel = {
			enabled = true,
			auto_refresh = false,
		},
		filetypes = {
			markdown = true,
		},
	},
}
