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
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope: Find Files" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope: Find Buffers" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope: Live Grep (text)" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope: Search Help" },
		{ "<leader>fG", "<cmd>Telescope git_files<cr>", desc = "Telescope: Git Files" },
		{ "<leader>fc", "<cmd>Telescope git_commits<cr>", desc = "Telescope: Git Commits" },
		{ "<leader>ts", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Telescope: LSP Document Symbols" },
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
