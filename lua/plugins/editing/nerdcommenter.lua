return {
	"preservim/nerdcommenter",
	cmd = { "NERDCommenterToggle", "NERDCommenterComment" },
	config = function()
		vim.g.NERDSpaceDelim = 1
		vim.g.NERDCompactSexyComs = 1
	end,
}
