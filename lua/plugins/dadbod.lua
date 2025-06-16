return {
  -- Backend for database connections
  "tpope/vim-dadbod",
  -- UI for vim-dadbod
  {
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

      -- Optional: Configure the default query tool if needed
      -- For SQL Server, if sqlcmd is not in your default PATH or you have a specific version:
      -- vim.g.db_ui_default_query_tool = '/opt/mssql-tools/bin/sqlcmd'
    end,
    config = function()
      -- Further configuration if needed, e.g., custom keymaps
    end,
  },
}
