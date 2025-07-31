-- PLUGIN 8: nvim-tree.lua - A modern file explorer.
-- Very useful for navigating project directories.
return { 'nvim-tree/nvim-tree.lua',
    version = '*', -- Use '*' to get the latest stable version unless specific version is needed
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- For file icons (requires a Nerd Font)
    config = function()
        require('nvim-tree').setup {
            -- `filters` configuration has changed. `exclude_dir` is now part of `custom`.
            filters = {
                dotfiles = false,
                -- Use `custom` for both file and directory exclusions.
                custom = { 'npm-debug.log', 'yarn-error.log', '.git', 'node_modules', '.cache' },
            },
            actions = {
                open_file = {
                    quit_on_open = true, -- Close nvim-tree automatically after opening a file
                    resize_window = true,
                },
            },
            view = {
                width = 50,          -- Default width of the tree
                relativenumber = true, -- Show relative numbers in the tree view
                side = 'left',       -- Position the tree on the left side
            },
            renderer = {
                group_empty = true,
                highlight_git = "all", -- `highlight_git` moved directly under `renderer`
            },
            git = {
                ignore = false,      -- Don't ignore files in .gitignore
                -- highlight = true ,    -- This highlights the git status signs in the tree view
            },
            update_focused_file = {
                enable = true,       -- Keep tree in sync with currently open buffer
                update_root = true,
                ignore_list = {},
            },
        }
        -- Keybindings for nvim-tree
        vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle NvimTree (file explorer)' })
        vim.keymap.set('n', '<leader>E', ':NvimTreeFocus<CR>', { desc = 'Focus NvimTree' })
    end
}
