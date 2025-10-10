return {
	"preservim/nerdcommenter",
	keys = {
		{ "<leader>c ", "<cmd>NERDCommenterToggle<CR>", desc = "NerdCommenter: Toggle comment" },
		{ "<leader>cc", "<cmd>NERDCommenterComment<CR>", desc = "NerdCommenter: Add comment" },
	},
	config = function()
		vim.g.NERDSpaceDelim = 1
		vim.g.NERDCompactSexyComs = 1
	end,
}
