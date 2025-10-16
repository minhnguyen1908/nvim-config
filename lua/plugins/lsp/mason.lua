-- Manages the installation of LSP servers, linters, and formatters.
return {
	"mason-org/mason.nvim",
	config = function()
		require("mason").setup({
			ensure_installed = {
				"sql-formatter",
			},
		})
	end,
}
