return {
    -- UI for vim-dadbod, which depends on the core vim-dadbod plugin
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        "tpope/vim-dadbod", -- Make sure dadbod is loaded first
        "kristijanhusak/vim-dadbod-completion", -- Optional: for autocompletion
        "tpope/vim-dotenv", -- Optional: for loading connections from .env files
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    init = function()
        vim.g.db_ui_use_nerd_fonts = 1 -- Set to 1 if you use Nerd Fonts for icons
        vim.g.db_ui_show_database_icon = 1
        vim.g.db_ui_win_position = 'left' -- Or 'right'
        vim.g.db_ui_winwidth = 40
        vim.g.db_debug = 1 -- Debug log from dadbod.

        -- Configure Dadbod to use 'sql' (sqlcl) for Oracle connections.
        vim.g.db_type_options = vim.tbl_deep_extend('force', vim.g.db_type_options or {}, {
            oracle = {
                db_cmd = '/bin/echo "Hello from db_cmd"', -- Tell Dadbod to use the sql executable for Oracle
                -- Commads to run when connecting with sqlcl for better output.
                init_commands = {
                    --'HOST export SQLCL_HOME=/opt/oracle/sqlcl;',
                    --'HOST export DYLD_LIBRARY_PATH="/opt/oracle/instantclient_23_3:/usr/local/lib";',
                    --'SET SQLFORMAT ANSICONSOLE;', -- Recommanded for human-readable tabular output.
                    --'SET FEEDBACK OFF;',          -- Suppress "X rows selected".
                    --'SET TERMOUT ON;',            -- Ensure output is displayed.
                    --'SET PAGESIZE 0;',            -- No pagination, show all rows.
                    --'SET LINESIZE 1000;',          -- Adjust line width as desired.
                    --'HOST sql -v;',
                    --'PROMPT This is SQLCL speaking!',
                },
            },
        })
        -- Optional: Configure the default query tool if needed
        -- For SQL Server, if sqlcmd is not in your default PATH or you have a specific version:
        -- vim.g.db_ui_default_query_tool = '/opt/mssql-tools/bin/sqlcmd'
    end,
    config = function()
        -- Further configuration if needed, e.g., custom keymaps
    end,
}
