-- Manages the installation of LSP servers, linters, and formatters.
return {
	"mason-org/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim", -- Optional: Automatically install tools
	},
	config = function()
		require("mason").setup()
		require("mason-tool-installer").setup({
			ensure_istalled = {
				"lua_ls", -- Lua language server
				"sql-formatter", -- SQL formatter
				"stylua", -- Lua code formatter
				"prettier", -- Code formatter for various languages
				"xmllint", -- XML formatter
			},
		})
	end, -- `config = true` uses the default configuration.
}
