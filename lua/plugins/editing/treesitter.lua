-- PLUGIN 1: nvim-treesitter for intelligent syntax highlighting and indentation.
-- This uses a parsing engine for more accurate and robust highlighting than traditional regex.
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate", -- Command to run after installation to download language parsers.
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"regex",
				"lua",
				"python",
				"javascript",
				"typescript",
				"html",
				"css",
				"json",
				"yaml",
				"markdown",
				"bash",
				"sql",
			}, -- List of languages to install parsers for.
			auto_install = true, -- Automatically install missing parsers when entering buffer.
			highlight = { enable = true }, -- Enable syntax highlighting.
			indent = { enable = true }, -- Enable smart indentation.
		})
		vim.treesitter.language.register("sql", "dadbod-sql-query")
		vim.treesitter.language.register("sql", "dbui-query") -- Older convention
		vim.treesitter.language.register("sql", "plsql")
	end,
}
