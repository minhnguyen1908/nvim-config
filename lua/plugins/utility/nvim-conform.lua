-- File: ~/.config/nvim/lua/plugins/conform.lua
return {
	"stevearc/conform.nvim",
	dependencies = { "williamboman/mason.nvim" },
	event = { "BufWritePre" }, -- Load before writing a buffer to disk
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
	config = function()
		require("conform").setup({
			formatters = {
				["sql-formatter"] = {
					command = "sql-formatter",
					args = { "--config", '{"language": "postgresql", "tabWidth": 2}' },
				},
				xmllint = {
					command = "xmllint",
					args = { "--format", "-" },
				},
			},
			-- This section sets up a filetype and the formatters to use for it
			formatters_by_ft = {
				-- Format all your Lua files with stylua on save
				lua = { "stylua" },

				-- Format your SQL files with sql-formatter on save
				sql = { "sql-formatter" },

				-- For XML, we can use xmllint (if installed)
				xml = { "xmllint" },

				-- Add other file types and formatters as you need them
				javascript = { "prettier" },
				yaml = { "prettier" },
				json = { "prettier" },
			},
			-- This section sets up the formatting trigger
			format_on_save = {
				-- Set 'lsp_fallback' to true to use the LSP formatter if no conform formatter is found
				lsp_fallback = true,
				async = false, -- Synchronous formatting, which is more reliable
				timeout_ms = 1000,
			},
		})
	end,
}
