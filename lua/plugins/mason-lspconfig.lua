-- Bridges mason.nvim with the nvim-lspconfig plugin, making it easier to set up LSP servers.
return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	opts = {
		ensure_installed = {
			"dockerls",
			"docker_compose_language_service",
			"lua_ls",
			"bashls",
			"jsonls",
			"yamlls",
			"pyright",
			"html",
			"cssls",
			"marksman",
			"sqlls",
			"tsserver",
		},
	},
}
