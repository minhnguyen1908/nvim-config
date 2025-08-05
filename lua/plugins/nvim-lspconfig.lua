return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        local lspconfig = require('lspconfig')
        local attach_lsp_keymaps = require('keymaps')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        local servers = {
            'dockerls',
            'docker_compose_language_service',
            'lua_ls',
            'bashls',
            'jsonls',
            'yamlls',
            'pyright',
        }

        for _, server_name in ipairs(servers) do
            lspconfig[server_name].setup({
                on_attach = attach_lsp_keymaps,
                capabilities = capabilities,
            })
        end
    end,
}
