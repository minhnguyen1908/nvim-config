-- File: lua/plugins/which-key.lua
return {
	"folke/which-key.nvim",
	event = "VeryLazy", -- Load this plugin very late, as it's only needed for UI.
	init = function()
		-- This sets the timeout length to 300ms, which feels much more responsive.
		vim.o.timeoutlen = 300
	end,
	config = function()
		require("which-key").setup({
			-- Your configuration can go here, or you can leave it empty
			-- to use the default settings, which are excellent.
		})
	end,
}
