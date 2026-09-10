return {
	"folke/snacks.nvim",
	opts = {
		picker = {
			sources = {
				projects = {
					confirm = { "cd", "load_session" },
				},
				explorer = {
					layout = {
						auto_hide = { "input" },
					},
				},
			},
		},
	},
}
