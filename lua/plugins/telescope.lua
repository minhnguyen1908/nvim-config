-- PLUGIN 9: telescope.nvim - A highly extensible fuzzy finder.
-- Incredibly powerful for quickly finding files, text content, Git commits, and more.
return { 'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- For fast C-base sorting.
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    }, -- Plenary is a dependency for Telescope
    opts = {
        find_files = {
            find_command = { 'fd', '--type', 'f', '--hiddend', '--exclude', '.git', '--exclude', 'node_modules' },
        },
        git_files = {
            find_command = { 'git', 'ls-files', '--exclude-standard' },
        },
        file_previewer = require('telescope.previewer').vim_buffer_previewer,
        grep_previewer = require('telescope.previewer').vim_buffer_previewer,
    },
    keys = {
        -- Basic File and Buffer Pickers
        { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Telescope: Find Files' },
        { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = 'Telescope: Find Buffers' },
        { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'Telescope: Live Grep (text)' },
        { '<leader>fh', function() require('telescope.buildin').help_tags() end, desc = 'Telescope: Search Help' },

        -- GIT Pickers (This is how you use the Git integration)
        { '<leader>fG', function() require('telescope.builtin').git_files() end, desc = 'Telescope: Git Files' },
        { '<leader>fc', function() require('telescope.builtin').git_commits() end, desc = 'Telescope: Git Commits' },
        { '<leader>ts', function() require('telescope.builtin').lsp_document_symbols() end, desc = 'Telescope: LSP Document Symbols' },
    },
}
