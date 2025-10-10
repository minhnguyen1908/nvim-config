-- File: ~/.config/nvim/lua/plugins/conform.lua
return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' }, -- Load before writing a buffer to disk
    config = function()
        require('conform').setup({
            formatters = {
                xmllint = {
                    command = 'xmllint',
                    args = { '--format', '-' },
                },
            },
            -- This section sets up a filetype and the formatters to use for it
            formatters_by_ft = {
                -- Format all your Lua files with stylua on save
                lua = { 'stylua' },

                -- Format your SQL files with sql-formatter on save
                sql = { 'sql-formatter' },

                -- For XML, we can use xmllint (if installed)
                xml = { 'xmllint' },

                -- Add other file types and formatters as you need them
                javascript = { 'prettier' },
                yaml = { 'prettier' },
                json = { 'prettier' },
            },
            -- This section sets up the formatting trigger
            format_on_save = {
                -- Set 'lsp_fallback' to true to use the LSP formatter if no conform formatter is found
                lsp_fallback = true,
                async = false, -- Synchronous formatting, which is more reliable
                timeout_ms = 1000,
            },
        })

        -- You can also create a keymap to format a file manually
        vim.keymap.set({ 'n', 'v' }, '<leader>fm', function()
            require('conform').format({ async = true, lsp_fallback = true })
        end, { desc = 'Format File' })
    end,
}
