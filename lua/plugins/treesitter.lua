-- PLUGIN 1: nvim-treesitter for intelligent syntax highlighting and indentation.
-- This uses a parsing engine for more accurate and robust highlighting than traditional regex.
return { 
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate', -- Command to run after installation to download language parsers.
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = { 'dockerfile', 'lua', 'bash', 'json', 'yaml', 'python', 'sql' }, -- Ensure Dockerfile and other common DevOps parsers are installed.
            highlight = { enable = true },       -- Enable syntax highlighting.
            indent = { enable = true },          -- Enable smart indentation.
        }
        vim.treesitter.language.register("sql", "dadbod-sql-query")
        vim.treesitter.language.register("sql", "dbui-query") -- Older convention
        vim.treesitter.language.register("sql", "plsql")
    end,
}
