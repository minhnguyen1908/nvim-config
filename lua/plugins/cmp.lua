-- PLUGIN 6: nvim-cmp for intelligent autocompletion.
-- This takes suggestions from LSP, buffers, paths, and presents them in a nice pop-up.
return { 'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',    -- Source for LSP completion
        'hrsh7th/cmp-buffer',      -- Source for completion from words in the current buffer
        'hrsh7th/cmp-path',        -- Source for file path completion
        'L3MON4D3/LuaSnip',        -- Snippet engine (required if you want code snippets)
        'saadparwaiz1/cmp_luasnip', -- Source for LuaSnip snippets
        'rafamadriz/friendly-snippets', -- Collection of popular snippets
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local cmp_autopairs = require('nvim-autopairs.completion.cmp') -- For autopairs integration

        -- This is the crucial part: defining the capabilities object.
        -- neodev will augment this object to add the Neovim runtime info.
        local capabilities = require('cmp_nvim_lsp').default_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        )

        cmp.setup({
            auto_select = false, -- do not auto select the text in popup window of nvim-cmp.

            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- For LSP snippets
                end,
            },
            window = {
                completion = cmp.config.window.bordered(), -- Makes the completion pop-up bordered
                documentation = cmp.config.window.bordered(), -- Makes the documentation pop-up bordered
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Scroll documentation up
                ['<C-f>'] = cmp.mapping.scroll_docs(4),  -- Scroll documentation down
                ['<C-Space>'] = cmp.mapping.complete(),  -- Manually trigger completion
                -- Modify the <CR>
                ['<CR>'] = cmp.mapping(function (fallback)
                   if cmp.visible() and cmp.get_selected_entry() then
                        cmp.confirm({ select = true }) -- Confirm the explicitly selected item.
                    else
                        fallback() -- Otherwise, perform default Enter action (new line)
                   end
                end, { 'i', 's' }),
                -- Optional: navigate through snippets with Tab/Shift+Tab
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },    -- Primary source from LSP servers
                { name = 'luasnip' },     -- Source for snippets
                { name = 'buffer' },      -- Source from words in the current buffer
                { name = 'path' },        -- Source for file paths
            })
        })

        -- Enable completion for the command line (`:`)
        cmp.setup.cmdline(':', {
            sources = cmp.config.sources({
                { name = 'path' },
                { name = 'cmdline' }
            })
        })

        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
    -- Export the capabilities object so lspconfig can use it.
    opts = function(_, opts)
        opts.capabilities = require('cmp_nvim_lsp').default_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        )
        return opts
    end,
}
