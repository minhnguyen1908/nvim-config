-- PLUGIN 9: telescope.nvim - A highly extensible fuzzy finder.
-- Incredibly powerful for quickly finding files, text content, Git commits, and more.
return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-ui-select.nvim",
	},
	opts = {
		find_files = {
			find_command = { "fd", "--type", "f", "--hiddend", "--exclude", ".git", "--exclude", "node_modules" },
		},
		git_files = {
			find_command = { "git", "ls-files", "--exclude-standard" },
		},
		file_previewer = require("telescope.previewers").vim_buffer_previewer,
		grep_previewer = require("telescope.previewers").vim_buffer_previewer,
	},
	config = function()
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})
		require("telescope").load_extension("ui-select")
	end,
}
