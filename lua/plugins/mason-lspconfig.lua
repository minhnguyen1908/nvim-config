-- Bridges mason.nvim with the nvim-lspconfig plugin, making it easier to set up LSP servers.
return {
	"williamboman/mason-lspconfig.nvim",
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"dockerls",
				"docker_compose_language_service",
				"lua_ls",
				"bashls",
				"jsonls",
				"yamlls",
				"pyright",
				"tsserver",
				"html",
				"cssls",
				"marksman",
				"sqlls",
			},
			automatic_installation = true,
		})
	end,
}
