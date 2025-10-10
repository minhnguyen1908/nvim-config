return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local attach_lsp_keymaps = require("keymaps")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local servers = {
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
		}

		for _, server_name in ipairs(servers) do
			vim.lsp.config(server_name, {
				on_attach = attach_lsp_keymaps,
				capabilities = capabilities,
			})
		end
	end,
}
